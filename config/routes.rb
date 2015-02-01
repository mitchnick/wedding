Wedding::Application.routes.draw do
  devise_for :admins, :skip => [:registrations]
  get "home/index"
  root to: 'home#index'
  resources :messages
  resources :guests

  get 'all_admin', to: 'admins#index'

  devise_scope :admin do
    get "admin", to: "devise/sessions#new"
  end
end
