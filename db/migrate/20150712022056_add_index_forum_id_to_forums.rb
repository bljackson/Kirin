class AddIndexForumIdToForums < ActiveRecord::Migration
  def change
  	add_index :forums, :parent_id
  end
end
