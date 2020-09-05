Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      resources :houses 
      resources :favorites
      post "/login", to: "users#login"
      post "/signup", to: "users#create"
      post "/house/:id/favorite", to: "houses#favorite"
      get "/users/:id/faforites", to: "users#favorites"
      get "/auto_login", to: "users#auto_login"
    end
  end
end
