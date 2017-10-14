module ApplicationHelper

  def cl_image_url(video)
    "#{Video.cl_base_url}/#{video.image_id}"
  end
end
