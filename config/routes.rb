Rails.application.routes.draw do
  namespace :api do
    resources :products
  end
  
  devise_for :users, controllers: { sessions: 'sessions' }
end
