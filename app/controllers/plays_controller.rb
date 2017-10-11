class PlaysController < ApplicationController
  def create
    @play = Play.new(play_params)
    @video = Video.find(params[:play][:video])
    @play.price = @video.price
    @play.user = current_user
    if @play.save
      @video.update_views(@play)
      @user.subtract_balance(@play)
    else
      print @user.errors.full_messages
    end
  end

  private

  def play_params
    params.require(:play).permit(:video, :duration)
  end
end
