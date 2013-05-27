class AddDepartmentToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :department, :string
  end
end
