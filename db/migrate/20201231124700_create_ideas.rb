class CreateIdeas < ActiveRecord::Migration[6.1]
  def change
    create_table :ideas do |t|
      t.string :title
      t.string :description
      t.references :idea_category, null: false, foreign_key: true
      t.string :status
      t.boolean :possibility_reward
      t.boolean :possibility_business

      t.timestamps
    end
  end
end
