Rails.application.routes.draw do
  devise_for :users
  # resources :games, only: [:index, :show, :update]
  # root to: "games#index"
  root to: "games#home", as: 'home'
  get 'game', to: "games#index", as: 'games'
  get 'game/:id/result', controller: 'games', action: :result, as: 'game'
  patch 'game/:id/result', controller: 'games', action: :update

  get 'profile', controller: 'games', action: :profile, as: 'profile'
end
