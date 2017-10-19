class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?




  protected
    def after_sign_in_path_for(resource)
      if request.referrer.gsub(/\?.*/, '') == landing_url
        video_id = params['video_id']
        embed_path(video_id) || root_path
      else
        super
      end
    end

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:full_name])
      devise_parameter_sanitizer.permit(:account_update, keys: [:full_name])
    end
end
