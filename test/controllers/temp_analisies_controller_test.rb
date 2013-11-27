require 'test_helper'

class TempAnalisiesControllerTest < ActionController::TestCase
  setup do
    @temp_analisy = temp_analisies(:one)
  end

  test "should create temp_analisy" do
    assert_difference('TempAnalisy.count') do
      post :create, temp_analisy: { algoritms_rate: @temp_analisy.algoritms_rate, date: @temp_analisy.date, percentage_rate: @temp_analisy.percentage_rate, current_rate: @temp_analisy.current_rate, medium_rate: @temp_analisy.medium_rate, period: @temp_analisy.period }
    end

    assert_redirected_to temp_analisy_path(assigns(:temp_analisy))
  end

  test "should update temp_analisy" do
    patch :update, id: @temp_analisy, temp_analisy: { algoritms_rate: @temp_analisy.algoritms_rate, date: @temp_analisy.date, percentage_rate: @temp_analisy.percentage_rate, current_rate: @temp_analisy.current_rate, medium_rate: @temp_analisy.medium_rate, period: @temp_analisy.period }
    assert_redirected_to temp_analisy_path(assigns(:temp_analisy))
  end

  test "should destroy temp_analisy" do
    assert_difference('TempAnalisy.count', -1) do
      delete :destroy, id: @temp_analisy
    end

    assert_redirected_to temp_analisies_path
  end
end
