Rails.application.routes.draw do
  root 'home#index'
  get ':short' => 'urls#show'
  resource :urls, only: :create
end
