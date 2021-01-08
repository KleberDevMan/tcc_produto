class CreateCollaborations < ActiveRecord::Migration[6.1]
  def change
    create_table :collaborations do |t|
      t.references :user, null: false, foreign_key: true
      t.references :idea, null: false, foreign_key: true
      t.boolean :quit
      t.timestamp :collaboration_date
      t.timestamp :withdrawal_date
      t.string :reason

      t.timestamps
    end
  end
end
