class AddColumnsIntoCartItems < ActiveRecord::Migration
  def change
  remove_column :cart_items , :check_in
  remove_column :cart_items , :check_out
  add_column :cart_items , :check_in_date , :date
  add_column :cart_items , :start_time, :time
  add_column :cart_items , :end_time, :time
  end
end
