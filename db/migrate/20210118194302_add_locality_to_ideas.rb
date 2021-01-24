class AddLocalityToIdeas < ActiveRecord::Migration[6.1]
  def change
    add_column :ideas, :locality, :string
  end
end
