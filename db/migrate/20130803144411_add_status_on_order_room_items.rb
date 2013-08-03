class AddStatusOnOrderRoomItems < ActiveRecord::Migration
  def change
  	add_column :order_room_items, :status, :string
  end
end
