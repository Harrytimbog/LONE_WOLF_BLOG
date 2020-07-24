Rails.application.routes.draw do
  devise_for :users
  root to: 'posts#index'
  get "posts/my_own", to: "posts#my_own", as: :my_own
  get 'user/dashboards#show', to: "user/dashboards#show", as: :my_profile
  resources :chatrooms, only: :show do
    resources :messages, only: :create
  end

  resources :posts, except: :index do
    resources :reviews, only: [:new, :create]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
