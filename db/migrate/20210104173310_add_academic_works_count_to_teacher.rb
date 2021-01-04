class AddAcademicWorksCountToTeacher < ActiveRecord::Migration[6.1]
  def change
    add_column :teachers, :academic_works_count, :integer, default: 0
  end
end
