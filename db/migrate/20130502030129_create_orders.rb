class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.date    :order_at
      t.integer :user_id
      t.string  :type
      t.string  :status
      t.decimal :amount
      t.text    :message
      t.timestamps
    end
  end
end