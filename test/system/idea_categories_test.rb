require "application_system_test_case"

class IdeaCategoriesTest < ApplicationSystemTestCase
  setup do
    @idea_category = idea_categories(:one)
  end

  test "visiting the index" do
    visit idea_categories_url
    assert_selector "h1", text: "Idea Categories"
  end

  test "creating a Idea category" do
    visit idea_categories_url
    click_on "New Idea Category"

    fill_in "Name", with: @idea_category.name
    fill_in "Status", with: @idea_category.status
    click_on "Create Idea category"

    assert_text "Idea category was successfully created"
    click_on "Back"
  end

  test "updating a Idea category" do
    visit idea_categories_url
    click_on "Edit", match: :first

    fill_in "Name", with: @idea_category.name
    fill_in "Status", with: @idea_category.status
    click_on "Update Idea category"

    assert_text "Idea category was successfully updated"
    click_on "Back"
  end

  test "destroying a Idea category" do
    visit idea_categories_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Idea category was successfully destroyed"
  end
end
