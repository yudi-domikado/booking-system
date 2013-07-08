class AddCompanyIdAndFullNameToCartItem < ActiveRecord::Migration
  def change
    add_column :cart_items,  :title,      :string
    add_column :cart_items,  :company_id, :integer
    add_column :order_items, :title,      :integer
    add_column :order_items, :company_id, :integer
  end
end
