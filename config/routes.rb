Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "home#index"
  delete "/", to: "home#logout"
  post "/", to: "home#login"
  resources :events, only: [:index]
end
