module AuthHelper
  def user_sign_in(id)
    session[:user_id] = id
  end

  def user_signed_in?
    !session[:user_id].nil?
  end

  def login_cookie_set?
    !session[:user_cookie_hash].nil?
  end

  def set_login_cookie
    cookies[:user_cookie_hash] = {
      value: session[:user_id],
      expires: 1.week.from_now
    }
  end

  def delete_login_cookie
    cookies.delete(:user_cookie_hash)
  end
  
  def get_login_cookie
    cookie[:user_cookie_hash]
  end

  def user_sign_out
    session[:user_id] = nil
    delete_login_cookie
  end

  def current_user
    User.where(id: session[:user_id]).first
  end
end
