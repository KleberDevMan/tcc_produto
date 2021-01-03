class AddTypeCollaboratorToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :type_collaborator, :string
  end
end
