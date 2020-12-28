json.extract! academic_work, :id, :title, :author, :summary, :course, :defense_date, :document, :document_link, :type, :keyword, :how_to_quote, :appraisers, :created_at, :updated_at
json.url academic_work_url(academic_work, format: :json)
