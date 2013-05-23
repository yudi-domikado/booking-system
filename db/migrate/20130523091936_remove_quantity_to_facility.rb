class RemoveQuantityToFacility < ActiveRecord::Migration
  def up
    remove_column :facilities, :quantity
    remove_column :facilities, :unlimited
    add_column :facilities, :description, :string
  end

  def down
  	remove_column :facilities, :description
  	add_column :facilities, :unlimited, :boolean
    add_column :facilities, :quantity, :integer
  end
end
