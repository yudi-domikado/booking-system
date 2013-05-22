class AddAmmountToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :ammount, :integer
  end
end
