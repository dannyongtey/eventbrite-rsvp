Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "home#index"
  delete "/", to: "home#logout"
  post "/", to: "home#login"
  post "/events", to: "events#update"
  resources :events, only: [:index] do 
  	resources :attendees, only: [:index]
  	get "/email", to: "attendees#email", as: :email
  	post "/email", to: "attendees#sending", as: :send
  	get "/rsvp", to: "attendees#update", as: :update
  end
end
