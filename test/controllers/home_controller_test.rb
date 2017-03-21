require 'test_helper'

class HomeControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get set_your_budget" do
    get :set_your_budget
    assert_response :success
  end

  test "should get about_us" do
    get :about_us
    assert_response :success
  end

end
