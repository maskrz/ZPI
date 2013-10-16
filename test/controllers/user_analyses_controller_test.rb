require 'test_helper'

class UserAnalysesControllerTest < ActionController::TestCase
  setup do
    @user_analysis = user_analyses(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:user_analyses)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create user_analysis" do
    assert_difference('UserAnalysis.count') do
      post :create, user_analysis: { rate: @user_analysis.rate }
    end

    assert_redirected_to user_analysis_path(assigns(:user_analysis))
  end

  test "should show user_analysis" do
    get :show, id: @user_analysis
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @user_analysis
    assert_response :success
  end

  test "should update user_analysis" do
    patch :update, id: @user_analysis, user_analysis: { rate: @user_analysis.rate }
    assert_redirected_to user_analysis_path(assigns(:user_analysis))
  end

  test "should destroy user_analysis" do
    assert_difference('UserAnalysis.count', -1) do
      delete :destroy, id: @user_analysis
    end

    assert_redirected_to user_analyses_path
  end
end
