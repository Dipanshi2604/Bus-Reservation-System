Rails.application.routes.draw do

  resources :buses do
    resources :reservations
  end
  resources :buses do
    member do
      get 'reservation_date', to: 'buses#reservation_date'
      get 'available_seats', to: 'buses#available_seats'
    end
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
  root to: "home#index"
  get "/my_buses"=> "my_buses#index"
  get "/user_bookings"=> "user_bookings#index"
  get "/search_bus"=> "buses#search_bus"

  devise_for :users, controllers: {
        sessions: 'users/sessions'
      }

  # Defines the root path route ("/")
  # root "posts#index"
end

