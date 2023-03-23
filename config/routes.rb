Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    passwords: 'users/passwords'
  }
  namespace :api do
    namespace :v1 do
    resources :lists
    end
  end




end
 