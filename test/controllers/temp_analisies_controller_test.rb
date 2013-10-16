require 'test_helper'

class TempAnalisiesControllerTest < ActionController::TestCase
  setup do
    @temp_analisy = temp_analisies(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:temp_analisies)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create temp_analisy" do
    assert_difference('TempAnalisy.count') do
      post :create, temp_analisy: { algoritms_rate: @temp_analisy.algoritms_rate, date: @temp_analisy.date, highest_rate: @temp_analisy.highest_rate, lowest_rate: @temp_analisy.lowest_rate, medium_rate: @temp_analisy.medium_rate, period: @temp_analisy.period }
    end

    assert_redirected_to temp_analisy_path(assigns(:temp_analisy))
  end

  test "should show temp_analisy" do
    get :show, id: @temp_analisy
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @temp_analisy
    assert_response :success
  end

  test "should update temp_analisy" do
    patch :update, id: @temp_analisy, temp_analisy: { algoritms_rate: @temp_analisy.algoritms_rate, date: @temp_analisy.date, highest_rate: @temp_analisy.highest_rate, lowest_rate: @temp_analisy.lowest_rate, medium_rate: @temp_analisy.medium_rate, period: @temp_analisy.period }
    assert_redirected_to temp_analisy_path(assigns(:temp_analisy))
  end

  test "should destroy temp_analisy" do
    assert_difference('TempAnalisy.count', -1) do
      delete :destroy, id: @temp_analisy
    end

    assert_redirected_to temp_analisies_path
  end
end
