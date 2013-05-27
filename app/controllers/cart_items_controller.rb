class CartItemsController < ApplicationController

	def update
		@cart_item = CartItem.find(params[:id])
		@cart_item.update_attributes(params[:cart_item])
		params[:cart_item][:facility_ids] = params[:facility_ids].join(",") if params[:facility_ids].present?
		flash[:alert] = @cart_item.errors.full_messages.uniq.to_sentence unless @cart_item.valid? 
		redirect_to carts_path
	end

	def destroy
		@cart_item = CartItem.find(params[:id])
		@cart_item.destroy
		redirect_to carts_path
	end


end