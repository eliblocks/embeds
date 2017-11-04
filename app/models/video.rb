class Video < ApplicationRecord
  include ClipUploader[:clip]
  belongs_to :user
  has_many :plays


  def signed_cloudfront_url
    signer = Aws::CloudFront::UrlSigner.new(
      key_pair_id: ENV["CLOUDFRONT_KEY_ID"],
      private_key: ENV["CLOUDFRONT_PRIVATE_KEY"]
    )
    url = signer.signed_url(cloudfront_url, policy: policy.to_json)
  end

  def cloudfront_url
    domain_id = ENV["CLOUDFRONT_DOMAIN_ID"]
    "https://#{domain_id}.cloudfront.net/#{clip.id}"
  end

  #error on non mp4 ending
  def fastly_url
    "https://browzable.global.ssl.fastly.net/#{clip.id[0..-5]}.m3u8"
  end

  def cdn_url
    if ENV['CDN_USED'] == 'fastly'
      fastly_url
    else
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
    "http://res.cloudinary.com/eli/image/upload"
  end

  def image_url
    "#{Video.cl_base_url}/#{image_id}"
  end

  def duration
    return 0 unless clip.metadata['duration']
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

end
