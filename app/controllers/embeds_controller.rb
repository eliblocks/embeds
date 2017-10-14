class EmbedsController < ApplicationController


  def show
    @video = Video.find(params[:id])
    unless user_signed_in?
      redirect_to landing_path(video_id: @video.id)
    end
  end

  def landing
    @video = Video.find(params[:video_id])
  end

  def redirect_to_sign_in
    unless user_signed_in?
      redirect_to landing_path(video_id: @video.id)
    end
  end
end
