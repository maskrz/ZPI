require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "authenticate successful" do
    @user = User.where(email: "test@gmail.com").take
    assert @user.authenticate("test1test")
  end
  
  test "authenticate failure" do
    @user = User.where(email: "test@gmail.com").take
    assert_equal false, @user.authenticate("false_password")
  end
  
  test "display name" do
    @user = User.where(email: "test@gmail.com").take
    assert_equal @user.first_name + " " +@user.last_name + " "+ @user.email, "Maciej Testowy test@gmail.com"    
  end
end
