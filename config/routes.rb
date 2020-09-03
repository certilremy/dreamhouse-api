Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      resources :houses 
      post "/login", to: "users#login"
      post "/signup", to: "users#create"
      get "/auto_login", to: "users#auto_login"
    end
  end
end
