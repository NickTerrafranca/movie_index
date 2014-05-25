data = [{:id=>"3542", :title=>"Breath Made Visible: Anna Halprin", :year=>"2010", :synopsis=>nil, :rating=>nil, :genre=>"Documentary", :studio=>"Argot Pictures"}]
# data.each do |h|
#   h.each do |k, v|
#   unless v == 0 || v == nil || v == ""

#   end

# end

require 'csv'
require 'pry'
MOVIES = 'movies.csv'

def read_movie_data(file_name)
  movies = []
  CSV.foreach(file_name, headers: true, header_converters: :symbol) do |row|
    movies << row.to_hash
  end
  movies
end


def filter_movies(file_name)
  filtered_movies = []
  movies = read_movie_data(MOVIES)
  movies.each do |movie|
    nil_counter = 0
    movie.each do |k, v|
      if v == 0 || v == nil || v == ""
        nil_counter += 1
      end
    end
    if nil_counter == 0
      filtered_movies << movie
    end
  end
    # binding.pry
  filtered_movies
end

puts filter_movies(MOVIES)
