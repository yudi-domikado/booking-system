class RemoveCartIdFromOrderItems < ActiveRecord::Migration
  def up
    remove_column :order_items, :cart_id
  end

  def down
    add_column :order_items, :cart_id, :integer
  end
end
