class PlaysController < ApplicationController
  def create
    @play = Play.new(play_params)
    @video = Video.find(params[:play][:video_id])
    @play.price = @video.price
    @play.user = current_user
    if @play.save
      @video.update_views(@play)
      print "user#{current_user}"
      print "account: #{current_user.account}"
      current_user.account.subtract_balance(@play)

    else
      print @play.errors.full_messages
    end
  end

  private

  def play_params
    params.require(:play).permit(:video_id, :duration)
  end
end
