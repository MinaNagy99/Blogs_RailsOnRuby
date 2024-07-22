Rails.application.routes.draw do
  root "users#new"

  resources :articles do
    resources :comments
  end
  resources :tags, only: [:create]

  resources :users, except: [:show]  # Exclude :new since we handle it separately
  get 'login', to: 'users#login', as: 'login'  # Route to login page
  post 'login', to: 'users#login', as: 'login_post'  # Route to login action
  post 'logout', to: 'users#log_out', as: 'logout'  # Route to logout action

end
