Rails.application.routes.draw do

   # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.

  get "up" => "rails/health#show", as: :rails_health_check
  root to: "home#index"
  get "/user_bookings"=> "user_bookings#index"

  scope module: 'owner' do
    resources :buses, except: %i[show] do 
      resources :reservations, only: [:index]
    end
  end

  resources :buses, only: [:show] do
    member do
      get 'reservation_date'
      get 'available_seats'
    end
  
    collection do
      get 'search_bus'
    end
  
    resources :reservations, except: [:index]
  end
 
  devise_for :users, controllers: {
        sessions: 'users/sessions'
      }
end

