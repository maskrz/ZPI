ActiveAdmin.register User do
  
  index do 
    column :first_name
    column :last_name
  default_actions
  end
  
  controller do
    def permitted_params
      params.permit user: [:first_name, :last_name, :email]
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
