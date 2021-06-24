Rails.application.routes.draw do
  devise_for :users
  # resources :games, only: [:index, :show, :update]
  # root to: "games#index"
  root to: "games#index", as: 'games'
  get 'game/:id/result', controller: 'games', action: :result, as: 'game'
  patch 'game/:id/result', controller: 'games', action: :update

  get 'profile', controller: 'users', action: :show, as: 'profile'
end
