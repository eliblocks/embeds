require 'omdbapi'

video = Video.first
movie = OMDB.id("tt#{video.imdb_id}")
puts movie
