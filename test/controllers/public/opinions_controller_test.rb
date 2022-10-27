require "test_helper"

class Public::OpinionsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get public_opinions_new_url
    assert_response :success
  end

  test "should get show" do
    get public_opinions_show_url
    assert_response :success
  end
end
