class AddFieldsToAcademicWork < ActiveRecord::Migration[6.1]
  def change
    add_column :academic_works, :institution, :string
    add_reference :academic_works, :course, null: false, foreign_key: true
  end
end
