class AddLinkOrDocToAcademicWorks < ActiveRecord::Migration[6.1]
  def change
    add_column :academic_works, :link_or_doc, :string
  end
end
