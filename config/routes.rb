Wedding::Application.routes.draw do

  devise_for :admins, :skip => [:registrations]
  get "home/index"
  root to: 'home#index'
  resources :messages
  resources :guests do
    resources :rsvps, except: [:index]
  end
  resources :rsvps, only: [:index]

  match 'rsvp', to: 'rsvps#enter_rsvp_code', as: :rsvp_code, via: [:get, :post]

  resources :admins do
    collection do
      get 'edit_password'
      patch 'update_password'
    end
  end

  get 'all_admin', to: 'admins#index'

  devise_scope :admin do
    get "admin", to: "devise/sessions#new"
  end
end
