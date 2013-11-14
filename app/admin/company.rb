ActiveAdmin.register Company do

  index do 
    column :id
    column :shortcut
    column :name
    column "Full id", :description
    column :created_at
  default_actions  
  end
  
  filter :indices, :collection => proc { Index.order(:name).all }
  filter :shortcut
  filter :name
  filter :description
  filter :created_at
  
  controller do
    def permitted_params
      params.permit company: [:shortcut, :name, :description]
    end
  end
  
  # See permitted parameters documentation:
  # https://github.com/gregbell/active_admin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # permit_params :list, :of, :attributes, :on, :model
  #
  # or
  #
  # permit_params do
  #  permitted = [:permitted, :attributes]
  #  permitted << :other if resource.something?
  #  permitted
  # end
  
end
