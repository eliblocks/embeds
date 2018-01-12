Tmdb::Api.key(ENV['TMDB_SECRET'])

desc "refresh movie data"
task update_movie_data: [:environment] do
  Video.movies.each do |video|
    movie = Tmdb::Find.imdb_id("tt#{video.imdb_id}")
    unless movie['movie_results'].empty?
      movie = Tmdb::Movie.detail(movie['movie_results'][0]['id'])
      runtime = movie['runtime']
      language = movie['original_language']
      description = movie['overview'][0..254]
      genres = movie['genres'].map { |genre| genre['name'] }.join(",")
      release_date = movie['release_date']
      puts video.update(runtime: runtime,
                        language: language,
                        description: description,
                        published_at: release_date)
      video.tag_list = genres
      sleep 0.5
    end
  end
end
