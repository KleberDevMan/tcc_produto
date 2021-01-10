class RemoveIdeaCategoryFromIdeas < ActiveRecord::Migration[6.1]
  def change
    remove_column :ideas, :idea_category_id
  end
end
