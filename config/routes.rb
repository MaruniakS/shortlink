Rails.application.routes.draw do
  root 'home#index'
  resource :urls, only: :create
end
