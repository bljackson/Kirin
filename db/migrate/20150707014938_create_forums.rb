class CreateForums < ActiveRecord::Migration
  def change
    create_table :forums do |t|
      t.string :name
      t.text :description
      t.integer :position
      t.integer :parent_id
    	t.string :parent_type

      t.timestamps
    end
  end
end
