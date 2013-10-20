ActiveAdmin.register CompanysIndices do

  controller do
    def permitted_params
      params.permit message: [:company, :index]
    end
    
  end
  
end
