Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  root to: "home#index"

  
  namespace :admin do
    root to: "home#index"
    resources :hotels
  end
end
