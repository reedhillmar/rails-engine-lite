Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  namespace :api do
    namespace :v1 do
      get '/items/:id/merchant', to: 'items/merchants#show'
      get '/merchants/find', to: 'merchants#find'
      get '/items/find_all', to: 'items#find_all'

      resources :merchants, only: %i[index show] do
        resources :items, module: :merchants, only: %i[index]
      end

      resources :items, only: %i[index show create update destroy]
    end
  end
end
