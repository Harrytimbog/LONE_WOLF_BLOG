Rails.application.routes.draw do
  devise_for :users
  root to: 'posts#index'
  get "posts/my_posts", to: "posts#my_posts", as: :my_posts
  get 'user/dashboards#show', to: "user/dashboards#show", as: :my_profile
  resources :categories

  resources :chatrooms, only: :show do
    resources :messages, only: :create
  end

  resources :posts do
    resources :reviews, only: [:new, :create]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
