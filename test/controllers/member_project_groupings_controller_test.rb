require 'test_helper'

class MemberProjectGroupingsControllerTest < ActionController::TestCase
  setup do
    @member_project_grouping = member_project_groupings(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:member_project_groupings)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create member_project_grouping" do
    assert_difference('MemberProjectGrouping.count') do
      post :create, member_project_grouping: { id: @member_project_grouping.id, m_id: @member_project_grouping.m_id, p_id: @member_project_grouping.p_id }
    end

    assert_redirected_to member_project_grouping_path(assigns(:member_project_grouping))
  end

  test "should show member_project_grouping" do
    get :show, id: @member_project_grouping
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @member_project_grouping
    assert_response :success
  end

  test "should update member_project_grouping" do
    patch :update, id: @member_project_grouping, member_project_grouping: { id: @member_project_grouping.id, m_id: @member_project_grouping.m_id, p_id: @member_project_grouping.p_id }
    assert_redirected_to member_project_grouping_path(assigns(:member_project_grouping))
  end

  test "should destroy member_project_grouping" do
    assert_difference('MemberProjectGrouping.count', -1) do
      delete :destroy, id: @member_project_grouping
    end

    assert_redirected_to member_project_groupings_path
  end
end
