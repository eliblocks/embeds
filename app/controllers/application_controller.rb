class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  protected
    def after_sign_in_path_for(resource)
      if request.referrer.gsub(/\?.*/, '') == landing_url
        video_id = params['video_id']
        embed_path(video_id) || root_path
      else
        super
      end
    end
end
