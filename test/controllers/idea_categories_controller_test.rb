require "test_helper"

class IdeaCategoriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @idea_category = idea_categories(:one)
  end

  test "should get index" do
    get idea_categories_url
    assert_response :success
  end

  test "should get new" do
    get new_idea_category_url
    assert_response :success
  end

  test "should create idea_category" do
    assert_difference('IdeaCategory.count') do
      post idea_categories_url, params: { idea_category: { name: @idea_category.name, status: @idea_category.status } }
    end

    assert_redirected_to idea_category_url(IdeaCategory.last)
  end

  test "should show idea_category" do
    get idea_category_url(@idea_category)
    assert_response :success
  end

  test "should get edit" do
    get edit_idea_category_url(@idea_category)
    assert_response :success
  end

  test "should update idea_category" do
    patch idea_category_url(@idea_category), params: { idea_category: { name: @idea_category.name, status: @idea_category.status } }
    assert_redirected_to idea_category_url(@idea_category)
  end

  test "should destroy idea_category" do
    assert_difference('IdeaCategory.count', -1) do
      delete idea_category_url(@idea_category)
    end

    assert_redirected_to idea_categories_url
  end
end
