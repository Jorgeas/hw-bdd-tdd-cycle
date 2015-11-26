class AddDirectorToMovies < ActiveRecord::Migration
  def change
    add_column :movies, :director, :string, limit: 255
  end
end
