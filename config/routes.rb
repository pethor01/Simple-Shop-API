require "sidekiq/web"
Rails.application.routes.draw do

  namespace :api, defaults: {format: :json} do
    namespace :v1 do
      resources :authentications, only: :create
      resources :products
      resources :regions
      resources :orders, only: %i[create show update destroy]
    end
  end
end
