require 'csv'
MOVIES = 'movies.csv'
def read_movie_data(file_name)
  movies = []
  CSV.foreach(file_name, headers: true, header_converters: :symbol) do |row|
    movies << row.to_hash
  end
  movies[0]
end

# def parse_movie_titles(file_name)
#   movie_title = []
#   films = read_movie_data(MOVIES)

#   films.each do |movie|
#     unless movie_title.include?(movie[:title])
#       movie_title << [movie[:title], movie[:id]]
#     end
#   end
#   movie_title
# end

def parse_movie_titles(file_name)
  movie_title = []
  films = read_movie_data(MOVIES)

  films.each do |movie|

    unless movie_title.include?(movie[:title])
      movie_title << movie[:title] << movie[:id]
    end
  end
  movie_title
end
# p parse_movie_titles(MOVIES)
p read_movie_data(MOVIES)
