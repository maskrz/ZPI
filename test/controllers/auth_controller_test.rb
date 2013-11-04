require 'test_helper'

class AuthControllerTest < ActionController::TestCase
  
  test "confirm_email" do
    token = "regHashTestowy"
    user = User.where(registration_hash: token).take
    assert user.email == "test@gmail.com"
  end
  
  #test "should create user" do
   # @user = User.new("first_name"=>"dasdas", "last_name"=>"sadasd", "email"=>"assda@jsha.pl", "password"=>"sadasd", "password_hash"=>"asda", "registration_hash"=>"addasda", "last_logged_at(1i)"=>"2013", "last_logged_at(2i)"=>"11", "last_logged_at(3i)"=>"4", "last_logged_at(4i)"=>"11", "last_logged_at(5i)"=>"06", "status"=>"0")
    #assert_difference('User.count') do
     # post :register, auth: params[@user]
    #end
 # end
  
end
