require "test_helper"

class PagesControllerTest < ActionDispatch::IntegrationTest
  test "should get denied" do
    get pages_denied_url
    assert_response :success
  end

  test "should get homepage" do
    get pages_homepage_url
    assert_response :success
  end
end
