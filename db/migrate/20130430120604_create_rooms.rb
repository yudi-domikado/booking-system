class CreateRooms < ActiveRecord::Migration
  def change
    create_table :rooms do |t|
      t.string     :name
      t.string     :description
      t.decimal    :price,      default: 0
      t.attachment :picture
      t.string     :slug
      t.timestamps
    end
  	add_index  :rooms, :slug, unique: true
  end
end
