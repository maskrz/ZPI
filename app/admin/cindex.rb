ActiveAdmin.register Cindex do

  index do
    column :id
    column :company
    column :index

    default_actions
  end
  
  filter :company, :collection => proc { Company.order(:name).all }
  filter :index, :collection => proc { Index.order(:name).all }
  
  controller do
    def permitted_params
      params.permit analisy: [:company, :index]
    end
  end

  form do |f|
    f.inputs "Edit Companys Indices" do
        f.input :company, :as => :select, :collection => Company.order(:name).all
        f.input :index,  :as => :select, :collection => Index.order(:name).all
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
