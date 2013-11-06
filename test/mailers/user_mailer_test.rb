require 'test_helper'

class UserMailerTest < ActionMailer::TestCase
  
  setup do
    @user = users(:one)
  end
  
  #test "after_sign_up" do 
   # @expected.from = 'no-reply@gpwanalizer.pl' 
   # @expected.to = 'test@gmail.com' 
   # @expected.subject = "Witaj w aplikacji GPW Analizer" 
   # 
   # @expected.body = read_fixture('after_sign_up') 
   # @expected.date = Time.now 
   # puts UserMailer.after_sign_up(@user).encoded 
    #assert_equal @expected.encoded, UserMailer.after_sign_up(@user).encoded 
  #end
end
