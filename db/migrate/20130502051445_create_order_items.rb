class CreateOrderItems < ActiveRecord::Migration
  def change
    create_table :order_items do |t|
      t.integer :order_id
      t.integer :price
      t.decimal :amount
      t.integer :quantity
      t.string  :itemable_type
      t.integer :itemable_integer
      t.timestamps
    end
  end
end
