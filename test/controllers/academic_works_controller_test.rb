require "test_helper"

class AcademicWorksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @academic_work = academic_works(:one)
  end

  test "should get index" do
    get academic_works_url
    assert_response :success
  end

  test "should get new" do
    get new_academic_work_url
    assert_response :success
  end

  test "should create academic_work" do
    assert_difference('AcademicWork.count') do
      post academic_works_url, params: { academic_work: { appraisers: @academic_work.appraisers, author: @academic_work.author, course: @academic_work.course, defense_date: @academic_work.defense_date, document: @academic_work.document, document_link: @academic_work.document_link, how_to_quote: @academic_work.how_to_quote, keyword: @academic_work.keyword, summary: @academic_work.summary, title: @academic_work.title, type: @academic_work.type } }
    end

    assert_redirected_to academic_work_url(AcademicWork.last)
  end

  test "should show academic_work" do
    get academic_work_url(@academic_work)
    assert_response :success
  end

  test "should get edit" do
    get edit_academic_work_url(@academic_work)
    assert_response :success
  end

  test "should update academic_work" do
    patch academic_work_url(@academic_work), params: { academic_work: { appraisers: @academic_work.appraisers, author: @academic_work.author, course: @academic_work.course, defense_date: @academic_work.defense_date, document: @academic_work.document, document_link: @academic_work.document_link, how_to_quote: @academic_work.how_to_quote, keyword: @academic_work.keyword, summary: @academic_work.summary, title: @academic_work.title, type: @academic_work.type } }
    assert_redirected_to academic_work_url(@academic_work)
  end

  test "should destroy academic_work" do
    assert_difference('AcademicWork.count', -1) do
      delete academic_work_url(@academic_work)
    end

    assert_redirected_to academic_works_url
  end
end
