require 'test_helper'

class TeamControllerControllerTest < ActionDispatch::IntegrationTest
  test "should get teams" do
    get team_controller_teams_url
    assert_response :success
  end

  test "should get new_team" do
    get team_controller_new_team_url
    assert_response :success
  end

  test "should get manage_team" do
    get team_controller_manage_team_url
    assert_response :success
  end

  test "should get join_team" do
    get team_controller_join_team_url
    assert_response :success
  end

  test "should get update_team" do
    get team_controller_update_team_url
    assert_response :success
  end

  test "should get add_to_team" do
    get team_controller_add_to_team_url
    assert_response :success
  end

  test "should get remove_from_team" do
    get team_controller_remove_from_team_url
    assert_response :success
  end

  test "should get delete_team" do
    get team_controller_delete_team_url
    assert_response :success
  end

end
