class AddCompanyToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :company, :string
  end
end
