class ChangeDefenseDateToAcademicWorks < ActiveRecord::Migration[6.1]
  def self.up
    change_column :academic_works, :defense_date, :string
  end
  def self.down
    change_column :academic_works, :defense_date, :date
  end
end
