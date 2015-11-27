class Movie < ActiveRecord::Base
  def self.all_ratings
    %w(G PG PG-13 NC-17 R)
  end
  
  def self.by_same_director(movie_id)
    #self.find_by director: self.find(movie_id).director
    movies = self.where(director: self.find(movie_id).director)
    return movies
  end
end
