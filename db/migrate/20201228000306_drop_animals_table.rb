class DropAnimalsTable < ActiveRecord::Migration[6.1]
  def up
    drop_table :animals
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end