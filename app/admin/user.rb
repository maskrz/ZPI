ActiveAdmin.register User do

  index do 
    column :first_name
    column :last_name
    column :email
    column :status
    default_actions
  end
  controller do
    def permitted_params
      params.permit user: [:first_name, :last_name, :email, :status]
    end
    
  end
  
  form do |f|
    f.inputs "User Details" do
      f.input :first_name
      f.input :last_name
      f.input :email
      f.input :status
    end
    f.actions
  end
  
  filter :first_name
  filter :last_name
  filter :email
  filter :status
  filter :last_logged_at
  filter :created_at
  filter :updated_at
end
