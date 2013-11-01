ZPI::Application.routes.draw do
  root :to => 'home#index'
  resources :analisies, :temp_analisies, :companies, :company, :indices, :index, :user_analyses, :messages, :users, :cindices
    
  scope :page, :controller => :static_pages do
      get 'about'
      get 'contact'
      get 'media'
      get 'home'
  end
  
  scope :ajax, :controller => :ajax do
    # get 'get_companies'
    get 'fetch_companies'
    get 'fetch_indices'
  end
end