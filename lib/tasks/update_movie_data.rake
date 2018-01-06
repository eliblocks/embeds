Tmdb::Api.key(ENV['TMDB_SECRET'])

desc "refresh movie data"
task update_movie_data: [:environment] do
  Video.movies.each do |video|
    movie = Tmdb::Find.imdb_id("tt#{video.imdb_id}")
    movie = Tmdb::Movie.detail(movie['movie_results'][0]['id'])
    runtime = movie['runtime']
    language = movie['original_language']
    description = movie['overview'][0..254]
    puts video.update(runtime: runtime, language: language, description: description)
    sleep 0.5
  end
end
