require "sidekiq/web"
Rails.application.routes.draw do
  devise_for :users, only: :omniauth_callbacks, controllers: {
    omniauth_callbacks: "users/omniauth_callbacks"
  }
  scope "(:locale)", locale: /en|vi/ do
    devise_for :users, skip: :omniauth_callbacks, controllers: {
        sessions: "users/sessions",
        registrations: "users/registrations",
        confirmations: "users/confirmations"
    }
    root "static_pages#home"
    get "/not_sell", to: "static_pages#not_sell"
    get "/price", to: "static_pages#price"
    get "/about", to: "static_pages#about"
    resources :users do
      resources :orders, only: [:show, :index]
    end
    namespace :admin do
      get "/", to: "dashboards#index"
      resources :movies
      resources :searchs, only: [:index, :create]
      resources :screenings, only: [:index, :new, :create, :destroy]
      resources :users, only: [:index, :show, :update]
      resource :block_users, only: [:create, :destroy]
      resource :privilege, only: [:create, :destroy]
      resources :rooms
      resources :affected_orders, only: [:index]
    end
    resources :movies, only: [:searchs, :screenings] do
      member do
        resources :screenings, only: [:index]
      end
    end
    resources :searchs, only: [:index]
    resources :rooms, only: [:show]
    resources :movies, only: [:show]
    resources :schedules, only: [:index]
    resources :showings, only: [:index]
    resources :comings, only: [:index]
    resources :orders, only: [:create]
    resources :accepts, only: [:index]
    resources :reactivations, only: [:new, :create, :show]
    get "/fails", to: "orders#destroy"
    authenticate :user, lambda { |u| u.admin? || u.mod? } do
      mount Sidekiq::Web => "/sidekiq"
    end
  end
end
