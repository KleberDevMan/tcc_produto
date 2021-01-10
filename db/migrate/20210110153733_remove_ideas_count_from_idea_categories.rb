class RemoveIdeasCountFromIdeaCategories < ActiveRecord::Migration[6.1]
  def change
    remove_column :idea_categories, :ideas_count
  end
end
