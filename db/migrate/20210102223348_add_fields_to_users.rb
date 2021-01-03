class AddFieldsToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :name, :string
    add_column :users, :telephone, :string
    add_column :users, :biography, :string
    add_column :users, :role, :string
  end
end
