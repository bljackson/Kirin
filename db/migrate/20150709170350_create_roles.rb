class CreateRoles < ActiveRecord::Migration
  def change
    create_table :roles do |t|
      t.string :name
      t.string :description

      t.timestamps
    end

    create_table :permissions do |t|
    	t.string :name
    	t.string :description
    end
  end
end
