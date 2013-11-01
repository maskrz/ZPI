ZPI::Application.routes.draw do
  root :to => 'home#index'
  resources :analisies, :temp_analisies, :companies, :company, :indices, :index, :user_analyses, :messages, :users, :cindices
    
  scope :page, :controller => :static_pages, :as => :page do
      get 'about'
      get 'contact'
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
    get 'sign_in', action: :login
    get 'sign_up', action: :register
    get 'sign_out', action: :logout
    get 'forgot_password'
    get 'confirm_email'
  end
end