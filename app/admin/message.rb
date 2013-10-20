ActiveAdmin.register Message do

  controller do
    def permitted_params
      params.permit message: [:content, :is_read, :reciver, :sender]
    end
    
  end

  
end
