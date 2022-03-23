Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  resources :courses, only: %i[index show] do
    resources :bookings, only: %i[create]
  end
  resources :bookings, only: %i[destroy]

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
