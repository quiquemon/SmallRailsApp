require 'test_helper'

class IndexControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get index_index_url
    assert_response :success
  end

  test "should get more_info" do
    get index_more_info_url
    assert_response :success
  end

  test "should get about_us" do
    get index_about_us_url
    assert_response :success
  end

end
