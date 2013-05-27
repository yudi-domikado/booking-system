class AddFaciityIdsToCartItem < ActiveRecord::Migration
  def change
    add_column :cart_items, :facility_ids, :string
  end
end
