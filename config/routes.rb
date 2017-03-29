Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'home#index'

  post   'make_friend',       to: 'home#make_friend'
  delete 'cancel_friend/:id', to: 'home#cancel_friend', as: :cancel_friend

  get 'message/:user_id/index', to: 'message#index', as: :message_index
  post 'message/:user_id', to: 'message#talk', as: :message_talk
  delete 'message/:user_id/:id', to: 'message#hide', as: :message_hide
end
