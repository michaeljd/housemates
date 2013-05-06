require 'test_helper'

class StatisticsControllerTest < ActionController::TestCase
  test "should get balances_graph" do
    get :balances_graph
    assert_response :success
  end

end
