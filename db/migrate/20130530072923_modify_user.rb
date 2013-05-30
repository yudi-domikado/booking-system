class ModifyUser < ActiveRecord::Migration
  def change
    add_column :users,  :company,     :string
    add_column :users,  :department,  :string
    add_column :users,  :phone,       :string
    add_column :orders, :phone,       :string
  end
end
