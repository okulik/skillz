Rails.application.routes.draw do
  root to: 'home#index'

  devise_for :users, controllers: { registrations: 'user_registrations' }
  devise_scope :user do
    get 'worker/sign_up', to: 'user_registrations#new', user: { rolable_type: 'worker' }
    post 'worker/sign_up', to: 'user_registrations#create', user: { rolable_type: 'worker' }
    get 'worker/edit', to: 'user_registrations#edit', user: { rolable_type: 'worker' }
    put 'worker/edit', to: 'user_registrations#update', user: { rolable_type: 'worker' }
    
    get 'customer/sign_up', to: 'user_registrations#new', user: { rolable_type: 'customer' }
    post 'customer/sign_up', to: 'user_registrations#create', user: { rolable_type: 'customer' }
    get 'customer/edit', to: 'user_registrations#edit', user: { rolable_type: 'customer' }
    put 'customer/edit', to: 'user_registrations#update', user: { rolable_type: 'customer' }
  end
  
  resources :workers, only: [:show, :update, :destroy] do
    get :jobs
  end

  resources :customers, only: [:update, :destroy] do
    get :jobs
    post :jobs
  end

  resources :jobs, only: [:new, :create]
end