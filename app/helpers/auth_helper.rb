module AuthHelper
  def self.auth(params)
      if @@user != nil
         if @@user.status > 1
           true
         else
           if params[:controller] == "users" && (params[:action] == "edit" || params[:action] == "update") && params[:id] == @@user.id
             true
           else
             false
           end
         end
      else
        false
      end
  end
end
