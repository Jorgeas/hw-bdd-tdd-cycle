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


Then /^I should be on the (.*) page for "(.*)"$/ do |page_name, movie_title|
  movie = Movie.find_by title: movie_title
  expect(path_to("#{page_name} page for \"#{movie_title}\"")).to eq(URI.parse(current_url).path)
  expect(page).to have_content(movie_title)
end

Then /^(?:|I )should either be on the (.+) page or the (.*) page$/ do |page_name_1, page_name_2|
  current_path = URI.parse(current_url).path
  expect(current_path).to eq(path_to(page_name_1)) or expect(current_path).to eq(path_to(page_name_2))
end

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
  rating_list.split(%r{,\s*}).each do |rating|
    if uncheck
      step "I uncheck rating #{rating}"
    else
      step "I check rating #{rating}"
    end
  end
end

Then /I should see all the movies/ do
  # Make sure that all the movies in the app are visible in the table
  rows = page.find_by_id('movies').first("tbody").all("tr").count()
  rows.should == 10
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.body is the entire content of the page as a string.
  page.body.index(e2).should > page.body.index(e1)
end