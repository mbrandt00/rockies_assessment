Rails.application.routes.draw do
  resources :averages, only: [:index, :show]
  post "/change_pitch_type", to: "averages#change_pitch_type"
end
