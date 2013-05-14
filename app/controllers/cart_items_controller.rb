class CartItemsController < ApplicationController

	def destroy
		@cart_item = CartItem.find(params[:id])
		@cart_item.destroy
		redirect_to carts_path
	end

	def update
		@cart_item = CartItem.find(params[:id])
		@cart_item.update_attributes(params[:cart_item])
		redirect_to carts_path
	end

end