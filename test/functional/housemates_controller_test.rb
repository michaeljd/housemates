require 'test_helper'

class HousematesControllerTest < ActionController::TestCase
  setup do
    @housemate = housemates(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:housemates)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create housemate" do
    assert_difference('Housemate.count') do
      post :create, housemate: { name: @housemate.name }
    end

    assert_redirected_to housemate_path(assigns(:housemate))
  end

  test "should show housemate" do
    get :show, id: @housemate
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @housemate
    assert_response :success
  end

  test "should update housemate" do
    put :update, id: @housemate, housemate: { name: @housemate.name }
    assert_redirected_to housemate_path(assigns(:housemate))
  end

  test "should destroy housemate" do
    assert_difference('Housemate.count', -1) do
      delete :destroy, id: @housemate
    end

    assert_redirected_to housemates_path
  end
end
