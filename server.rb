require 'sinatra'
require 'csv'
MOVIES = 'public/movies.csv'

def read_movie_data(file_name)
  movies = []
  CSV.foreach(file_name, headers: true, header_converters: :symbol) do |row|
    movies << row.to_hash
  end
  movies.sort_by { |movie| movie[:title] }
end

def parse_movie_titles(file_name)
  movie_title = []
  films = read_movie_data(MOVIES)
  films.each do |movie|
    unless movie_title.include?(movie[:title])
      movie_title << [movie[:title], movie[:id]]
    end
  end
  movie_title
end

get('/') do
  redirect '/movies'
end

get('/movies') do
  @movies = parse_movie_titles(MOVIES)
  erb :index
end

get('/movies/:id') do
  selected_movie = params[:id]
  all_movie_data = read_movie_data(MOVIES)
  @details = []

  all_movie_data.each do |movie|

      # binding.pry
    if movie[:id] == selected_movie
      @details << movie
    end
    @details
  end
  erb :movie_details
end

