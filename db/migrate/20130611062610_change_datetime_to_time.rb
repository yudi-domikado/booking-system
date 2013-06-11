class ChangeDatetimeToTime < ActiveRecord::Migration
  def up
    change_column :cart_items,  :start_time, :integer
    change_column :cart_items,  :end_time,   :integer
    change_column :order_items, :start_time, :integer
    change_column :order_items, :end_time,   :integer
  end

  def down
    change_column :cart_items,  :start_time, :datetime
    change_column :cart_items,  :end_time,   :datetime
    change_column :order_items, :start_time, :datetime
    change_column :order_items, :end_time,   :datetime
  end
end
