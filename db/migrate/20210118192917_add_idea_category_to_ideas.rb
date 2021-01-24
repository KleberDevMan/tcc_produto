class AddIdeaCategoryToIdeas < ActiveRecord::Migration[6.1]
  def change
    add_reference :ideas, :idea_category, null: false, foreign_key: true
  end
end
