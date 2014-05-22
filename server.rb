
MOVIES = 'public/movies.csv'
require 'sinatra'
require 'csv'

def read_movie_data(file_name)
  movies = []
  CSV.foreach(file_name, headers: true, header_converters: :symbol) do |row|
    movies << row.to_hash
  end
  movies
end


def parse_movie_titles(file_name)
  movie_title = []
  films = read_movie_data(MOVIES)
  films.each do |movie|
    if !movie_title.include?(movie[:title])
      movie_title << movie[:title]
    end
  end
  movie_title
end


get('/') do
  redirect ('/movies')
end

get('/movies') do
@movie = parse_movie_titles(MOVIES)

erb :index

end

