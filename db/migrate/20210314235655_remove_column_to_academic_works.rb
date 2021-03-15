class RemoveColumnToAcademicWorks < ActiveRecord::Migration[6.1]
  def up
    remove_column :academic_works, :doc
  end

  def down
    add_column :academic_works, :doc, :string
  end
end
