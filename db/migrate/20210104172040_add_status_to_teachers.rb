class AddStatusToTeachers < ActiveRecord::Migration[6.1]
  def change
    add_column :teachers, :status, :string
  end
end
