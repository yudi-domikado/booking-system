class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.datetime :order_at
      t.integer :user_id
      t.string  :type
      t.string  :status
      t.decimal :amount
      t.text    :message
      t.string  :code
      t.integer :code_number
      t.string  :slug
      t.timestamps
    end

    add_index :orders, :slug, unique: true
    add_index :orders, :code, unique: true
    add_index :orders, :type
    add_index :orders, :code_number

  end
end