class AddIdeasCountToIdeaCategories < ActiveRecord::Migration[6.1]
  def change
    add_column :idea_categories, :ideas_count, :integer, default: 0
  end
end
