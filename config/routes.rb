Rails.application.routes.draw do
  root to: 'pages#main'

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  resources :pages, only: [] do
    collection do
      get :main
    end
  end

  resources :games, defaults: { format: :json }
end
