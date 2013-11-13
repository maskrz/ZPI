ActiveAdmin.register Index do

  index do 
    column :id
    column :name
    column :created_at
  default_actions  
  end
  
  filter :companies, :collection => proc { Company.order(:name).all }
  filter :name
  filter :created_at
  
  controller do
    def permitted_params
      params.permit index: [:name]
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
