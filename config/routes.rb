ZPI::Application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  root 'home#index'
  scope :home, :controller =>:home do
    get 'main'
    get 'wall'
    get 'wall/archive/:company_id', action: :archive
    match 'user_edit', via: [:get, :patch]
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
    match 'order_analysis', via: [:get, :post]
    match 'get_user_analysis_history', via: [:get, :post]
    get 'get_user_company_analysis_for_day'
    match 'get_messages', via: [:get, :post]
  end
  
  scope :auth, :controller => :auth, :as => :auth do
    match 'sign_in', action: :login, via: [:get, :post]
    match 'sign_up', action: :register, via: [:get, :post]
    get 'sign_out', action: :logout
    match 'forgot_password', via: [:get, :post]
    match 'change_password', via: [:get, :post]
    match 'confirm_email', via: [:get, :post]
  end
  resources :analisies, :temp_analisies, :companies, :company, :indices, :index, :user_analyses, :messages, :users, :cindices
end