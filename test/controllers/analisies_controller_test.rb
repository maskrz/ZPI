require 'test_helper'

class AnalisiesControllerTest < ActionController::TestCase
  setup do
    @analisy = analisies(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:analisies)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create analisy" do
    assert_difference('Analisy.count') do
      post :create, analisy: { algoritms_rate: @analisy.algoritms_rate, date: @analisy.date, highest_rate: @analisy.highest_rate, lowest_rate: @analisy.lowest_rate, medium_rate: @analisy.medium_rate, period: @analisy.period }
    end

    assert_redirected_to analisy_path(assigns(:analisy))
  end

  test "should show analisy" do
    get :show, id: @analisy
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @analisy
    assert_response :success
  end

  test "should update analisy" do
    patch :update, id: @analisy, analisy: { algoritms_rate: @analisy.algoritms_rate, date: @analisy.date, highest_rate: @analisy.highest_rate, lowest_rate: @analisy.lowest_rate, medium_rate: @analisy.medium_rate, period: @analisy.period }
    assert_redirected_to analisy_path(assigns(:analisy))
  end

  test "should destroy analisy" do
    assert_difference('Analisy.count', -1) do
      delete :destroy, id: @analisy
    end

    assert_redirected_to analisies_path
  end
end
