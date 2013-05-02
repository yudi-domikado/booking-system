class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.date :order_at
      t.integer :user_id
      t.integer :total
      t.string :status
    end
  end
end