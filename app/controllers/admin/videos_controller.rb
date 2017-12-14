class Admin::VideosController < Admin::AdminController

  def index
    if params[:show_removed]
      @videos = Video.all.order(views: :desc)
    else
      @videos = Video.unremoved.order(views: :desc)
    end
  end

  def toggle_approval
    @video = Video.find(params[:id])
    if @video.approved
      @video.update(approved: false, featured: false)
    else
      @video.update(approved: true, suspended: false)
    end
    redirect_to admin_videos_path
  end

  def toggle_featured
    @video = Video.find(params[:id])
    if @video.featured
      @video.update(featured: false)
    else
      @video.update(featured: true, approved: true, suspended: false)
    end
    redirect_to admin_videos_path
  end

  def toggle_suspended
    @video = Video.find(params[:id])
    if @video.suspended
      @video.update(suspended: false)
    else
      @video.update(suspended: true, approved: false, featured: false)
    end
    redirect_to admin_videos_path
  end
end
