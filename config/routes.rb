Rails.application.routes.draw do
  get 'home/index'

  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'home#index'

  post 'make_friend', to: 'home#make_friend'
  delete 'cancel_friend/:id', to: 'home#cancel_friend', as: :cancel_friend
end
