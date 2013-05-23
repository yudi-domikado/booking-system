class AddQuantityToFacilities < ActiveRecord::Migration
  def change
    add_column :facilities, :quantity, :integer
  end
end
