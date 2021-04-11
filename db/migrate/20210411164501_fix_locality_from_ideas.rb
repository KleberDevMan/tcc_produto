class FixLocalityFromIdeas < ActiveRecord::Migration[6.1]
  def change
    rename_column :ideas, :locality, :city
  end
end
