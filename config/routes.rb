Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  root to: "home#index"
  get '/search', to: 'home#search'
  get '/promotions', to: 'home#promotions'
  
  resources :bookings
  resources :rooms

  get '/book', to: 'rooms#book'
  post '/book', to: 'rooms#save_book'

  namespace :admin do
    root to: "hotels#index"
    get "/metrics", to: "hotels#metrics"
    resources :hotels do
      resources :rooms
      resources :promotions
    end

    resources :rooms do
      resources :promotions, controller: 'promotions_rooms'
    end
  end

  namespace :api do
    post 'login', to: 'session#login'
    get 'profile', to: 'users#profile'
    resources :users
    resources :bookings
    resources :hotels do
      resources :promotions, controller: 'promotions_hotels'
      resources :rooms do
        resources :bookings
      end
    end
    resources :rooms do
      resources :promotions, controller: 'promotions_rooms'
      post 'book', on: :member
    end
  end
end
