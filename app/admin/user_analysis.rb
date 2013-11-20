ActiveAdmin.register UserAnalysis do

  index do
    column :id
    column :user
    column "Analisy" do |analisy|
      link_to analisy.id, admin_analisy_path(analisy)
    end
    default_actions
  end
  
  filter :user, :collection => proc { User.order(:last_name).all }
  filter :analisy, :collection => proc { Analisy.order(:id).all }
  filter :rate
  filter :created_at
  
  controller do
    def permitted_params
      params.permit user_analysis: [:user_id, :analisy_id, :rate]
    end
  end
  
  form do |f|
    f.inputs "Edit User Analysis" do
        f.input :user, :as => :select, :collection => User.order(:last_name).all
        f.input :analisy
        f.input :rate
    end
    f.actions
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
