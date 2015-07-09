class CreateTopics < ActiveRecord::Migration
  def change
    create_table :topics do |t|
      t.string :title
      t.text :description
      t.integer :forum_id
      t.integer :user_id
  	  t.boolean :closed, :null => false, :default => false
  	  t.boolean :pinned, :null => false, :default => false

      t.timestamps
    end
  end
end
