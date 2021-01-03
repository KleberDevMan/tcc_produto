require "application_system_test_case"

class ProfilesTest < ApplicationSystemTestCase
  setup do
    @profile = profiles(:one)
  end

  test "visiting the index" do
    visit profiles_url
    assert_selector "h1", text: "Profiles"
  end

  test "creating a Profile" do
    visit profiles_url
    click_on "New Profile"

    check "Active" if @profile.active
    fill_in "Description", with: @profile.description
    fill_in "Name", with: @profile.name
    fill_in "Namespace", with: @profile.namespace
    fill_in "Permissions", with: @profile.permissions
    click_on "Create Profile"

    assert_text "Profile was successfully created"
    click_on "Back"
  end

  test "updating a Profile" do
    visit profiles_url
    click_on "Edit", match: :first

    check "Active" if @profile.active
    fill_in "Description", with: @profile.description
    fill_in "Name", with: @profile.name
    fill_in "Namespace", with: @profile.namespace
    fill_in "Permissions", with: @profile.permissions
    click_on "Update Profile"

    assert_text "Profile was successfully updated"
    click_on "Back"
  end

  test "destroying a Profile" do
    visit profiles_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Profile was successfully destroyed"
  end
end
