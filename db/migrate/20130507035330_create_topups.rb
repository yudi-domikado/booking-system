class CreateTopups < ActiveRecord::Migration
  def change
    create_table :topups do |t|
      t.integer :user_id
      t.integer :credit
      t.date :topup_date
      t.timestamps
    end
  end
end
