class FixStateUfFromIdeas < ActiveRecord::Migration[6.1]
  def change
    rename_column :ideas, :state_uf, :state
  end
end
