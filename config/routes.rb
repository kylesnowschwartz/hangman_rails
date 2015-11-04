Rails.application.routes.draw do
  resources :games, except: [:update, :edit] do
    resources :guesses, only: :create
  end

  root to: 'games#index'
end
