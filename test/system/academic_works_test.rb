require "application_system_test_case"

class AcademicWorksTest < ApplicationSystemTestCase
  setup do
    @academic_work = academic_works(:one)
  end

  test "visiting the index" do
    visit academic_works_url
    assert_selector "h1", text: "Academic Works"
  end

  test "creating a Academic work" do
    visit academic_works_url
    click_on "New Academic Work"

    fill_in "Appraisers", with: @academic_work.appraisers
    fill_in "Author", with: @academic_work.author
    fill_in "Course", with: @academic_work.course
    fill_in "Defense date", with: @academic_work.defense_date
    fill_in "Document", with: @academic_work.document
    fill_in "Document link", with: @academic_work.document_link
    fill_in "How to quote", with: @academic_work.how_to_quote
    fill_in "Keyword", with: @academic_work.keyword
    fill_in "Summary", with: @academic_work.summary
    fill_in "Title", with: @academic_work.title
    fill_in "Type", with: @academic_work.type
    click_on "Create Academic work"

    assert_text "Academic work was successfully created"
    click_on "Back"
  end

  test "updating a Academic work" do
    visit academic_works_url
    click_on "Edit", match: :first

    fill_in "Appraisers", with: @academic_work.appraisers
    fill_in "Author", with: @academic_work.author
    fill_in "Course", with: @academic_work.course
    fill_in "Defense date", with: @academic_work.defense_date
    fill_in "Document", with: @academic_work.document
    fill_in "Document link", with: @academic_work.document_link
    fill_in "How to quote", with: @academic_work.how_to_quote
    fill_in "Keyword", with: @academic_work.keyword
    fill_in "Summary", with: @academic_work.summary
    fill_in "Title", with: @academic_work.title
    fill_in "Type", with: @academic_work.type
    click_on "Update Academic work"

    assert_text "Academic work was successfully updated"
    click_on "Back"
  end

  test "destroying a Academic work" do
    visit academic_works_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Academic work was successfully destroyed"
  end
end
