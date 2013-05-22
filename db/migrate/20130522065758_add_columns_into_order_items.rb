class AddColumnsIntoOrderItems < ActiveRecord::Migration
  def change
  	add_column :order_items , :check_in_date , :date
  	add_column :order_items , :start_time , :time
  	add_column :order_items , :end_time , :time
  	remove_column :order_items , :check_in 
  	remove_column :order_items , :check_out
  end
end
