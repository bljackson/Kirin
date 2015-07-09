class AddRoleIdToRolesUsers < ActiveRecord::Migration
  def up
    change_table :roles_users do |t|
      t.integer :role_id
      t.integer :user_id
 
      t.timestamps
    end
  end
end
