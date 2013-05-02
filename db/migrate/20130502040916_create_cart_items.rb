class CreateCartItems < ActiveRecord::Migration
  def change
    create_table :cart_items do |t|
      t.integer :room_id
      t.integer :cart_id
      t.datetime :check_in
      t.datetime :check_out
      t.integer :price
      t.timestamps
    end
  end
end
