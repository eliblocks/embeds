desc "Reset video minutes viewed"
task reset_views: [:environment] do
  Video.all.each do |video|
    puts "Old views: #{video.views}"
    video.update(views: video.seconds_played)
    puts "New views: #{video.views}"
  end
end
