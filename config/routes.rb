# frozen_string_literal: true

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check

  namespace :api do
    namespace :v1 do
      resources :users
      resources :movie_shows
      resources :movies
      resources :theaters
      resources :tickets
      resources :movie_in_theaters
      resources :roles

      resources :theaters do
        # Custom route for get_movie_show_by_theater_id
        get 'movie_shows_by_theater_id', to: 'movie_shows#get_movie_show_by_theater_id'
      end

      resources :movie_shows do
        get 'theater_by_movie_show_id', to: 'theaters#get_theater_by_movie_show_id'
      end
    end
  end
  devise_for :users, path: '', path_names: {
                                 sign_in: 'auth/login',
                                 sign_out: 'auth/logout',
                                 registration: 'auth/signup'
                               },
                     controllers: {
                       sessions: 'users/sessions',
                       registrations: 'users/registrations'
                     }
end
