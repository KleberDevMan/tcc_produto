class RemoveAncestryToMenus < ActiveRecord::Migration[6.1]
  def change
    remove_column :menus, :ancestry
  end
end
