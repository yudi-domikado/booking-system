class AddTotalToCartItems < ActiveRecord::Migration
  def change
    add_column :cart_items, :total, :integer
  end
end
