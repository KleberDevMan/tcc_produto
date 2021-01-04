class AddAcademicWorksCountToCourse < ActiveRecord::Migration[6.1]
  def change
    add_column :courses, :academic_works_count, :integer, default: 0
  end
end
