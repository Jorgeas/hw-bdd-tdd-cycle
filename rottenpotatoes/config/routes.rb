Rottenpotatoes::Application.routes.draw do
  # map '/' to be a redirect to '/movies'
  root :to => redirect('/movies')
  resources :movies
  get '/movies/:id/by_same_director', to: 'movies#by_same_director', as: 'director'
end
