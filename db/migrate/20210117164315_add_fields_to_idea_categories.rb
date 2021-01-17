class AddFieldsToIdeaCategories < ActiveRecord::Migration[6.1]
  def change
    add_column :idea_categories, :img_link, :string
    add_column :idea_categories, :img, :string
  end
end
