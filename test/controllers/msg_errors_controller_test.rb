require "test_helper"

class MsgErrorsControllerTest < ActionDispatch::IntegrationTest
  test "should get denied" do
    get msg_errors_denied_url
    assert_response :success
  end
end
