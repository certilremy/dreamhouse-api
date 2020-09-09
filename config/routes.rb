Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  namespace :api do
    namespace :v1 do
      resources :houses 
      resources :favorites
      post "/login", to: "users#login"
      post "/signup", to: "users#create"
      post "/house/:id/favorite", to: "houses#favorite"
      
     #This route is only  here to allow you make a user became admin very easy. I'm not planing to put it on a real live project
     # I put it here just in case you want to test the House endpoint in the live documentation. 
      get "/user/:id/admin", to: "users#b_admin"
      root 'houses#home'
    end
  end
end
