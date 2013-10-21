require 'test_helper'

class CindicesControllerTest < ActionController::TestCase
  setup do
    @cindex = cindices(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:cindices)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create cindex" do
    assert_difference('Cindex.count') do
      post :create, cindex: {  }
    end

    assert_redirected_to cindex_path(assigns(:cindex))
  end

  test "should show cindex" do
    get :show, id: @cindex
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @cindex
    assert_response :success
  end

  test "should update cindex" do
    patch :update, id: @cindex, cindex: {  }
    assert_redirected_to cindex_path(assigns(:cindex))
  end

  test "should destroy cindex" do
    assert_difference('Cindex.count', -1) do
      delete :destroy, id: @cindex
    end

    assert_redirected_to cindices_path
  end
end
