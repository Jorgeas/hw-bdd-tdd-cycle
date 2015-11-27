require 'rails_helper'

RSpec.describe MoviesController, type: :controller do
    describe 'find movies with same director' do
        before :each do
            @fake_results = [double('movie1'), double('movie2')]
        end
        it 'should call the movie method that selects movies with same director' do
            expect(Movie).to receive(:by_same_director).with('1') { @fake_results }
            allow(Movie).to receive(:find)
            get :by_same_director, {:id => '1'}
        end
        it 'should select the similar movie page for rendering' do
            allow(Movie).to receive(:by_same_director)
            allow(Movie).to receive(:find)
            get :by_same_director, {:id => '1'}
            expect(response).to render_template(:similar_movies)
        end
        it 'should show the movie 2 in the data' do
            allow(Movie).to receive(:by_same_director) { @fake_results }
            allow(Movie).to receive(:find)
            get :by_same_director, {:id => '1'}
            expect(response.body).to include("movie2")
        end
    end
end
