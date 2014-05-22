
require 'sinatra'
require 'csv'
require 'pry'
MOVIES = 'public/movies.csv'

def read_movie_data(file_name)
  movies = []
  CSV.foreach(file_name, headers: true, header_converters: :symbol) do |row|
    movies << row.to_hash
  end
  movies
end
# this returns a array of hashes

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
# this returns a array of arrays

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
    if movie[:id] == selected_movie
      @details << movie
    end
    @details
  end
  erb :movie_details
end

# When visiting the /movies path it should list all of the movies sorted by title. Each title should be a clickable
# link that takes you to /movies/:movie_id, where :movie_id is replaced by the numeric ID for that movie
# (e.g. /movies/2 will take you to the page for Troll 2).

# When visiting the /movies/:movie_id path, it should list the details for the movie identified by :movie_id.
# The details should include the title, the year released, the synopsis, the rating, the genre,
# and the studio that produced it (leave blank if any fields are not available).
