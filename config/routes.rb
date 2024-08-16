Rails.application.routes.draw do
  namespace :api do
    resources :products
  end
  
  devise_for :users, controllers: { sessions: 'sessions' }

  devise_scope :user do
    delete 'logout', to: 'sessions#destroy'
  end
end
