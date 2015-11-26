require 'rails_helper'

RSpec.describe MoviesController, type: :controller do
    describe 'add directo info to an existing movie' do
        it 'should call the movie method that updates data' do
            movie = {:rating => 'PG', :title => 'Alien', :release_date => '', :director => 'Ridley Scott'}
            movie.should_receive(:update).with('Ridley Scott')
            post :update, movie
            #post :update, {:rating => 'PG', :title => 'Alien', :release_date => '', :director => 'Ridley Scott'}
        end
        it 'should select the movie page for rendering' do
            Movie.stub(:update)
            post :update, {:rating => 'PG', :title => 'Alien', :release_date => '', :director => 'Ridley Scott'}
            expect(response).to render_template(:movie_info)
        end
        it 'should show the movie director in the data' do
            Movie.stub(:update)
            post :update, {:rating => 'PG', :title => 'Alien', :release_date => '', :director => 'Ridley Scott'}
            expect(response.body).to include("Ridley Scott")
        end
    end
end
