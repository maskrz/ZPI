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
  
  test "active is active test" do
    assert @user.is_active?
  end
  
  test "not active is active test" do
    @user2 = users(:two)
    assert_equal false, @user2.is_active?
  end
  
  test "display name test" do
    assert_equal "Maciej Testowy test@gmail.com", @user.display_name
  end
  
  test "full name test" do
    assert_equal "Maciej Testowy", @user.full_name
  end
  
  test "get analysies history test" do
    @analisies = @user.get_analysies_history
    assert_equal 2, @analisies.size
  end
  
end
