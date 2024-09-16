require "test_helper"

class StandupResponsesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get standup_responses_index_url
    assert_response :success
  end
end
