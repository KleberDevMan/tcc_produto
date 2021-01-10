class CreateIdeaCategoryIdeas < ActiveRecord::Migration[6.1]
  def change
    create_table :idea_category_ideas do |t|
      t.references :idea, null: false, foreign_key: true
      t.references :idea_category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
