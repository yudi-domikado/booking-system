class CreateCartRoomItems < ActiveRecord::Migration
  def change
    create_table :cart_room_items do |t|
      t.integer :room_id
      t.date    :check_in_date
      t.integer :start_time
      t.integer :end_time

      t.timestamps
    end
  end
end
