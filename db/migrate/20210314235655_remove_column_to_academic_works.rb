class RemoveColumnToAcademicWorks < ActiveRecord::Migration[6.1]
  def up
    if ActiveRecord::Base.connection.column_exists?(:academic_works, :doc)
      remove_column :academic_works, :doc
    end
  end

  def down
    add_column :academic_works, :doc, :string
  end
end
