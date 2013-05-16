class CreateFacilities < ActiveRecord::Migration
  def change
    create_table :facilities do |t|
    	t.string :name
    	t.integer :booking_id
      t.timestamps
    end
  end
end
