require 'test_helper'

class AnalisiesControllerTest < ActionController::TestCase
  setup do
    @analisy = analisies(:one)
  end

  test "should create analisy" do
    assert_difference('Analisy.count') do
      post :create, analisy: { algoritms_rate: @analisy.algoritms_rate, date: @analisy.date, percentage_rate: @analisy.percentage_rate, current_rate: @analisy.current_rate, medium_rate: @analisy.medium_rate, period: @analisy.period }
    end

    assert_redirected_to analisy_path(assigns(:analisy))
  end

  test "should update analisy" do
    patch :update, id: @analisy, analisy: { algoritms_rate: @analisy.algoritms_rate, date: @analisy.date, percentage_rate: @analisy.percentage_rate, current_rate: @analisy.current_rate, medium_rate: @analisy.medium_rate, period: @analisy.period }
    assert_redirected_to analisy_path(assigns(:analisy))
  end

  test "should destroy analisy" do
    assert_difference('Analisy.count', -1) do
      delete :destroy, id: @analisy
    end

    assert_redirected_to analisies_path
  end
end
