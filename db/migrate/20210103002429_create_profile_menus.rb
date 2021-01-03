class CreateProfileMenus < ActiveRecord::Migration[6.1]
  def change
    create_table :profile_menus do |t|
      t.references :menu, null: false, foreign_key: true
      t.references :profile, null: false, foreign_key: true

      t.timestamps
    end
  end
end
