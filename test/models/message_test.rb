require 'test_helper'

class MessageTest < ActiveSupport::TestCase
  setup do
    @message = messages(:one)
  end
  
  test "sender test" do
    @message.sender
    assert_equal 1, @message.sender_id
  end
  
  test "reciver test" do
    @message.reciver
    assert_equal 2, @message.reciver_id
  end
  
  test "is sender test" do
    assert @message.is_sender? 1
  end
  
end
