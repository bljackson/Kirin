class CreatRolesUsersJoinTable < ActiveRecord::Migration
  create_table :roles_users do |t|
		t.belongs_to :users, index: true
		t.belongs_to :roles, index: true
	  t.integer :role_id
	  t.integer :user_id
  end
end
