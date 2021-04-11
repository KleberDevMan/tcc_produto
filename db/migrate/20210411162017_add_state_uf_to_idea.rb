class AddStateUfToIdea < ActiveRecord::Migration[6.1]
  def change
    add_column :ideas, :state_uf, :string
  end
end
