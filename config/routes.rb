Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'omniauth_callbacks' }
  get 'design/components'
  get 'design/sections'

  root to: 'games#index'

  resources :companies do
    resources :critics, only: %i[index create destroy update]
  end

  resources :games do  # /games/
    post 'add_genre', on: :member
    delete 'remove_genre', on: :member

    post 'add_platform', on: :member
    delete 'remove_platform', on: :member

    resources :involved_companies, only: %i[create update]

    resources :critics, only: %i[index create destroy update]
  end
end
