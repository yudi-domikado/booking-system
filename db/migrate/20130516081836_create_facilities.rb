class CreateFacilities < ActiveRecord::Migration
  def change
    create_table :facilities do |t|
      t.string  :name
      t.integer :price
      t.integer :room_id
      t.timestamps
    end
  end
end
