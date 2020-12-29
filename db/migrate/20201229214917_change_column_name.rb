class ChangeColumnName < ActiveRecord::Migration[6.1]
  def change
    rename_column :academic_works, :type, :work_type
  end
end
