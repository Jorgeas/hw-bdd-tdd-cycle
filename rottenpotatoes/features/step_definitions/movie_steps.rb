# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
    Movie.create!(movie)
  end
end

# Movie step for opening edit page for a movie selected by title
Then /I go to the edit page for "(.*)"/ do |movie_title|
  # get movie index
  movie = Movie.find_by title: movie_title
  visit path_to("#{movie.id}/edit")
end

Then /the director of "(.*)" should be "(.*)"/ do |movie_title, director|
  # look for director in movie row
  expect(page).to have_content(movie_title) and expect(page).to have_content(director)
end
