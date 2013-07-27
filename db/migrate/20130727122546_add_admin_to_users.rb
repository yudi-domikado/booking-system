class AddAdminToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :is_admin, :boolean
  	add_column :orders, :message, :text
  end
end
