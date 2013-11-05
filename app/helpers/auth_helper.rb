module AuthHelper
  def sign_in_in(user)
    session[:user_id] = user.id
  end

  def signed_in?
    !session[:user_id].nil?
  end

  def sign_out
    session[:user_id] = nil
  end

  def current_user
    User.where(id: session[:user_id]).first
  end
end
