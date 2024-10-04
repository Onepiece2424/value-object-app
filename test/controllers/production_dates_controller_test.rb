require "test_helper"

class ProductionDatesControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get production_dates_new_url
    assert_response :success
  end

  test "should get create" do
    get production_dates_create_url
    assert_response :success
  end
end
