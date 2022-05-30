Rails.application.routes.draw do
  resources :averages, only: [:index]
end
