class AddTeacherToAcademicWorks < ActiveRecord::Migration[6.1]
  def change
    add_reference :academic_works, :teacher, null: false, foreign_key: true
  end
end
