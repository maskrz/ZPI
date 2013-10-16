require 'test_helper'

class StaticPagesControllerTest < ActionController::TestCase
  test "should get media" do
    get :media
    assert_response :success
  end

end
