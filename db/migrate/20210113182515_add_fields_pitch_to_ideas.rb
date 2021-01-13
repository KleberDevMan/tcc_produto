class AddFieldsPitchToIdeas < ActiveRecord::Migration[6.1]
  def change
    add_column :ideas, :problem_to_solve, :string
    add_column :ideas, :suffering_people, :string
    add_column :ideas, :proposed_solution, :string
    add_column :ideas, :differential, :string
  end
end
