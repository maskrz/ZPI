ZPI::Application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  root 'home#index'
  scope :home, :controller =>:home do
    get 'main'
    get 'wall'
  end
  scope :page, :controller => :static_pages, :as => :page do
    get 'about'
    match 'contact', via: [:get, :post]
    get 'media'
    get 'home'
  end
  
  scope :ajax, :controller => :ajax do
    get 'get_companies'
    get 'get_indices'
    get 'fetch_companies'
    get 'fetch_indices'
  end
  
  scope :auth, :controller => :auth, :as => :auth do
    match 'sign_in', action: :login, via: [:get, :post]
    match 'sign_up', action: :register, via: [:get, :post]
    get 'sign_out', action: :logout
    match 'forgot_password', via: [:get, :post]
    match 'confirm_email', via: [:get, :post]
  end
  resources :analisies, :temp_analisies, :companies, :company, :indices, :index, :user_analyses, :messages, :users, :cindices
end