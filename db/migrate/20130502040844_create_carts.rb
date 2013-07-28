class CreateCarts < ActiveRecord::Migration
  def change
    create_table :carts do |t|
      t.string  :session_id
      t.string  :type
      t.decimal :amount
      t.timestamps
    end
  end
end
