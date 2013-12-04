require 'test_helper'

class MessageTest < ActiveSupport::TestCase
  setup do
    @message = messages(:one)
  end
  
  test "is sender test" do
    assert @message.is_sender? 1
  end
  
end
