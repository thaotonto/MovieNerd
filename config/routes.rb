Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    root "static_pages#home"
    get "/signup", to: "users#new"
    post "/signup", to: "users#create"
    get "sessions/new"
    get "/login", to: "sessions#new"
    post "/login", to: "sessions#create"
    delete "/logout", to: "sessions#destroy"
    resources :users
    namespace :admin do
      resources :movies, :screenings
      resources :users, only: [:index, :update]
      resource :block_users, only: [:create, :destroy]
    end
    resources :movies, only: [:searchs] do
      collection do
        resources :searchs, only: [:index, :create]
      end
    end
    resources :account_activations, only: [:edit]
    resources :password_resets, only: [:new, :create, :edit, :update]
    resources :rooms, only: [:show]
  end
end
