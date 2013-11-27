require 'test_helper'

class AuthHelperTest < ActionView::TestCase
  setup do
    @user = users(:one)
  end
  
  test "sign_in" do
    user_sign_in(@user)
    @user2 = User.where(id: session[:user_id]).take
    assert_equal @user2.email, "test@gmail.com"
  end
  
  test "signed in? success" do
    user_sign_in(@user)
    assert user_signed_in?
  end
  
  test "signed in? failure" do
    assert_equal false, user_signed_in?
  end
  
  test "sign out" do
    user_sign_in(@user)
    user_sign_out
    assert_equal false, user_signed_in?
  end
  
  test "current user" do
    user_sign_in(@user)
    assert_equal @user, current_user
  end
    
end
