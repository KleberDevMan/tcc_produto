class CreateProfiles < ActiveRecord::Migration[6.1]
  def change
    create_table :profiles do |t|
      t.string :name
      t.string :description
      t.boolean :active
      t.json :permissions
      t.string :namespace

      t.timestamps
    end
  end
end
