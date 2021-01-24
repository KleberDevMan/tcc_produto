class AddTypeCollaborationToCollaborations < ActiveRecord::Migration[6.1]
  def change
    add_column :collaborations, :type_collaboration, :string
  end
end
