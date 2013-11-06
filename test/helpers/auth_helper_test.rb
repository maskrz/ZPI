require 'test_helper'

class AuthHelperTest < ActionView::TestCase
  setup do
    @user = users(:one)
  end
  
  test "sign_in" do
    sign_in_in(@user)
    @user2 = User.where(id: session[:user_id]).take
    assert_equal @user2.email, "test@gmail.com"
  end
  
  test "signed in? success" do
    sign_in_in(@user)
    assert signed_in?
  end
  
  test "signed in? failure" do
    assert_equal false, signed_in?
  end
  
  test "sign out" do
    sign_in_in(@user)
    sign_out
    assert_equal false, signed_in?
  end
  
  test "current user" do
    sign_in_in(@user)
    assert_equal @user, current_user
  end
    
end
