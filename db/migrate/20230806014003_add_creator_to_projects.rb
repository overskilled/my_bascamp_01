class AddCreatorToProjects < ActiveRecord::Migration[7.0]
  def change
    add_reference :projects, :creator, null: false, foreign_key: { to_table: :users }
  end
end
