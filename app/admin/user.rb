ActiveAdmin.register User do
  
  index do 
    column :id
    column :first_name
    column :last_name
    column :email
    column :status
    column :last_logged_at
    column :created_at
  default_actions  
  end  
  
  filter :first_name
  filter :last_name
  filter :email
  filter :status
  filter :last_logged_at
  filter :created_at
    
  controller do
    def permitted_params
      params.permit user: [:id, :first_name, :last_name, :email, :status]
    end
  end
  
  form do |f|
    f.inputs "Edit User" do
        f.input :first_name
        f.input :last_name
        f.input :email
        f.input :status
    end
    f.actions
  end
  
  show do |f|
    attributes_table do
      row :id
      row :first_name
      row :last_name
      row :email
      row :status
    end
    active_admin_comments
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
