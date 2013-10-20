ActiveAdmin.register Analisy do
  index do
    column :company
    column :lowest_rate
    column :medium_rate
    column :highest_rate
    column :algoritms_rate
    column :period
    column :date
    default_actions
  end
  
  controller do
    def permitted_params
      params.permit analisy: [:company, :lowest_rate, :medium_rate, :highest_rate, :algoritms_rate, :date]
    end
    
  end
  

  filter :company
  filter :lowest_rate
  filter :medium_rate
  filter :highest_rate
  filter :algoritms_rate
  filter :period
  filter :date
end
