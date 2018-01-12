class Video < ApplicationRecord
  include ClipUploader[:clip]
  include AlgoliaSearch

  belongs_to :user
  has_many :taggings
  has_many :tags, through: :taggings
  has_many :plays

  scope :approved, -> { where(approved: true) }
  scope :unremoved, -> { where(removed: false) }
  scope :listed, -> { where(public: true) }
  scope :featured, -> { where(featured: true) }
  scope :movies, -> { where.not(imdb_id: nil)}

  algoliasearch per_environment: true do
    attribute :title, :views
    searchableAttributes ['title']
    hitsPerPage 4
    customRanking ['desc(views)']
  end

  def self.tagged_with(name)
    Tag.find_by_name!(name).videos
  end

  def self.tag_counts
    Tag.select("tags.*, count(taggings.tag_id) as count").
    joins(:taggings).group("taggings.tag_id")
  end

  def tag_list
    tags.map(&:name).join(", ")
  end

  def tag_list=(names)
    self.tags = names.split(",").map do |n|
      Tag.where(name: n.strip).first_or_create!
    end
  end

  def signed_cloudfront_url
    signer = Aws::CloudFront::UrlSigner.new(
      key_pair_id: ENV["CLOUDFRONT_KEY_ID"],
      private_key: ENV["CLOUDFRONT_PRIVATE_KEY"]
    )
    url = signer.signed_url(cloudfront_url, policy: policy.to_json)
  end

  def cloudfront_url
    domain_id = ENV["CLOUDFRONT_DOMAIN_ID"]
    "https://#{domain_id}.cloudfront.net/#{s3_id}"
  end



  #error on non mp4 ending
  def fastly_url
    "https://browzable.global.ssl.fastly.net/#{clip.id[0..-5]}.m3u8"
  end

  def cdn_url
    if ENV['CDN_USED'] == 'fastly'
      fastly_url
    elsif ENV['CDN_USED'] == 'cloudfront'
      signed_cloudfront_url
    end
  end

  def policy
    {
       "Statement" => [
          {
             "Resource" => cloudfront_url,
             "Condition" => {
                "DateLessThan" => {
                   "AWS:EpochTime" => 1.days.from_now.to_i
                }
             }
          }
       ]
    }
  end

  def remove
    update(removed: true, approved: false, featured: false)
  end

  def remove_or_destroy
    plays.any? ? remove : destroy
  end

  def update_views(play)
    new_views = views + play.duration
    update(views: new_views)
  end

  def image_id
    image.split('/')[1]
  end

  def image_version
    image.split('/')[0]
  end

  def self.cl_base_url
    "https://res.cloudinary.com/eli/image/upload"
  end

  def image_url
    if image
      "#{Video.cl_base_url}/#{image_id}"
    else
      ActionController::Base.helpers.asset_path("jw_black.png")
    end
  end


  def duration
    return 0 unless clip && clip.metadata['duration']
    clip.metadata['duration'].round
  end

  def minutes
    views/60
  end

  def preview
    if image
      image_url
    else
      "jw_black.png"
    end
  end

  def seconds_played
    plays.sum(:duration) || 0
  end
end
