class RemoveColumns < ActiveRecord::Migration
  def self.up
  	remove_column :users, :email
  	remove_column :users, :password_digest
	end
end
