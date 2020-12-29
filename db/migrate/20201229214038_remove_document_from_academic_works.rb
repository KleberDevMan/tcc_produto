class RemoveDocumentFromAcademicWorks < ActiveRecord::Migration[6.1]
  def change
    remove_column :academic_works, :document, :string
  end
end
