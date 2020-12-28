class CreateAcademicWorks < ActiveRecord::Migration[6.1]
  def change
    create_table :academic_works do |t|
      t.string :title
      t.string :author
      t.string :summary
      t.string :course
      t.date :defense_date
      t.string :document
      t.string :document_link
      t.string :type
      t.string :keyword
      t.string :how_to_quote
      t.string :appraisers

      t.timestamps
    end
  end
end
