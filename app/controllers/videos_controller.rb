class VideosController < ApplicationController
  before_action :set_video, only: [:show, :edit, :update, :destroy, :remove, :restore]
  before_action :redirect_to_sign_up, only: [:new, :show, :edit, :update, :destroy]

  # GET /videos
  # GET /videos.json
  def index
    @videos = Video.featured
    .includes(:user)
    .order(created_at: :desc)
    .page(params[:page])
    .per(12)
  end

  # GET /videos/1
  # GET /videos/1.json
  def show
    set_cloudfront_cookies
    if @video.removed || @video.suspended
      render 'embeds/unavailable'
    end
    if current_account.balance < 10
      flash[:notice] = "You're out of minutes! Buy more to keep watching"
      session[:video_id] = @video.id
      session[:ref] = 'site'
      redirect_to new_charge_path()
    end
  end

  # GET /videos/new
  def new
    @video = Video.new
  end

  # GET /videos/1/edit
  def edit
    unless current_user == @video.user || current_user.admin?
      redirect_to root_url
    end
  end

  # POST /videos
  # POST /videos.json
  def create
    @video = Video.new(video_params)
    @video.user = current_user
    @video.image = Rails.configuration.default_image
    if @video.save
      puts "Success!"
    else
      puts "Fail: #{@video.error.full_messages}"
    end
    head :ok
  end

  # PATCH/PUT /videos/1
  # PATCH/PUT /videos/1.json
  def update
    params_with_image = video_params
    if params[:image_id].present?
      preloaded = Cloudinary::PreloadedFile.new(params[:image_id])
      raise "Invalid upload signature" if !preloaded.valid?
      params_with_image.merge!(image: preloaded.identifier)
    end

    if @video.update(params_with_image)
      flash[:success] = "Video successfully updated"
      redirect_to library_path
    else
      render :edit
    end
  end

  # DELETE /videos/1
  # DELETE /videos/1.json
  def destroy
    if @video.plays.any?
      @video.remove
      flash[:success] = 'Video successfully removed.'
      redirect_to library_path
    elsif @video.destroy
      flash[:success] = 'Video successfully destroyed.'
      redirect_to library_path
    else
      render 'edit'
    end
  end

  def restore
    if @video.update(removed: false)
      flash[:success] = "Video successfully restored"
      redirect_to library_path
    else
      render 'edit'
    end
  end

  def search
    @videos = Video
    .search(params[:q], page: params[:page])
    render 'index'
  end

  private

    def set_cloudfront_cookies
      signer = Aws::CloudFront::CookieSigner.new(
        key_pair_id: ENV["CLOUDFRONT_KEY_ID"],
        private_key: ENV["CLOUDFRONT_PRIVATE_KEY"]
      )
      url = "https://media.browzable.com/*"

      cloudfront_cookies = signer.signed_cookie(url, policy: cookie_policy.to_json)
      cookies['CloudFront-Policy'] = cloudfront_cookies['CloudFront-Policy']
      cookies['CloudFront-Key-Pair-Id'] = cloudfront_cookies['CloudFront-Key-Pair-Id']
      cookies['CloudFront-Signature'] = cloudfront_cookies['CloudFront-Signature']
      puts "cookies: #{cookies['Cloudfront-Policy']}"
    end

    def cookie_policy
      {
        "Statement": [
          {
            "Resource":"https://media.browzable.com/*",
            "Condition":{
              "DateLessThan":{"AWS:EpochTime" => 1.days.from_now.to_i}
            }
          }
        ]
      }
    end

    def encoded_policy
      Base64.encode64(cookie_policy.to_json)
    end

    def redirect_to_sign_up
      unless user_signed_in?
        flash[:notice] = "Sign up or log in to watch"
        redirect_to new_user_session_path
      end
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_video
      @video = Video.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def video_params
      params.require(:video).permit(:title, :description, :duration, :price,
                    :approved, :clip, :balance, :views, :user_id, :imdb_id, :public)
    end
end




#@videos = Video.approved.where.not(removed: true).where(public: true).includes(:user).order(created_at: :desc).page(params[:page]).per(12)
