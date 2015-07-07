class AddLockedToTopics < ActiveRecord::Migration
  def change
  	add_column :topics, :closed, :boolean, :null => false, :default => false
  	add_column :topics, :pinned, :boolean, :null => false, :default => false
  end
end
