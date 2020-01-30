Rails.application.routes.draw do
 devise_for :users
 resources :posts do
  resources :comments
  resources :likes
 end
 resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_scope :user do
    root to: 'devise/sessions#new'
  end

end
