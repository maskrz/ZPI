require 'test_helper'

class UserTest < ActiveSupport::TestCase
  setup do
    @user = users(:one)
    @user2 = User.new
  end
  
  test "authenticate successful" do
    assert true, @user.authenticate(Digest::MD5.hexdigest("test1test"))
  end
  
  test "authenticate failure" do
    assert_equal false, @user.authenticate("false_password")
  end
  
  test "display name" do
    assert_equal @user.first_name + " " +@user.last_name + " "+ @user.email, "Maciej Testowy test@gmail.com"    
  end
  
end
