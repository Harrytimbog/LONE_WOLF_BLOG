Rails.application.routes.draw do
  devise_for :users
  root to: 'posts#index'
  get "posts/my_posts", to: "posts#my_posts", as: :my_profile
  resources :categories

  resources :chatrooms do
    resources :messages, only: :create
  end

  resources :posts do
    resources :likes
    resources :reviews
    resources :comments
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
