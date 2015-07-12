class UpdateForumTable < ActiveRecord::Migration
  def change
    rename_column :forums, :category_id, :parent_id
    add_column :forums, :parent_type, :string
  end
end
