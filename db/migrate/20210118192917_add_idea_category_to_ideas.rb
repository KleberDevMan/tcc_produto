class AddIdeaCategoryToIdeas < ActiveRecord::Migration[6.1]
  def change
    add_reference :ideas, :idea_category, foreign_key: true
  end
end
