ActiveAdmin.register Analisy do

  index do 
    column :id
    column :lowest_rate
    column :medium_rate
    column :highest_rate
    column :algoritms_rate
    column :period
    column :date
    column :company
    column :created_at
  default_actions  
  end  
  
  filter :company, :collection => proc { Company.order(:name).all }
  filter :users, :collection => proc { User.order(:last_name).all }
  filter :lowest_rate
  filter :medium_rate
  filter :highest_rate
  filter :algoritms_rate
  filter :period
  filter :date
  filter :created_at
    
  controller do
    def permitted_params
      params.permit analisy: [:lowest_rate, :medium_rate, :highest_rate, :algoritms_rate]
    end
  end
  
  form do |f|
    f.inputs "Analisy Details" do
        f.input :lowest_rate
        f.input :medium_rate
        f.input :highest_rate
        f.input :algoritms_rate
    end
    f.actions
  end
  
  show do |f|
    attributes_table do
      row :id
      row :lowest_rate
      row :medium_rate
      row :highest_rate
      row :algoritms_rate
      row :period
      row :date
      row :company
      row :created_at
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
