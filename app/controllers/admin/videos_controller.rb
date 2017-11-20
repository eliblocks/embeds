class Admin::VideosController < Admin::AdminController

  def index
    @videos = Video.all.order(:views)
  end

  def toggle_approval
    @video = Video.find(params[:id])
    if @video.approved?
      @video.update(approved: false)
    else
      @video.update(approved: true)
    end
    redirect_to admin_videos_path
  end
end
