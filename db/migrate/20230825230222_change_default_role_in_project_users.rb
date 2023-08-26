class ChangeDefaultRoleInProjectUsers < ActiveRecord::Migration[7.0]
  def change
    change_column_default :project_users, :role, from: nil, to: "user"
  end
end
