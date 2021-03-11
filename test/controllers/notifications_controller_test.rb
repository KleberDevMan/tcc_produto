require "test_helper"

class NotificationsControllerTest < ActionDispatch::IntegrationTest
  test "should get clear" do
    get notifications_clear_url
    assert_response :success
  end
end
