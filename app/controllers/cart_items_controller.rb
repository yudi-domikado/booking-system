class CartItemsController < ApplicationController

	def update
	@cart_item = CartItem.find(params[:id])
	#mengambil parameter id dari form "cart_item/id // cart_item/23"
	@cart_item.update_attributes(params[:cart_item])
	#mengambil parameter dari objek pembentuk cart_item
	flash[:alert] = @cart_item.errors.full_messages.uniq.to_sentence unless @cart_item.valid? #apabila cart item invalid
	#menunjukan message alert dari model full sentence jika cart time tidak valid alias tidak melewati
	redirect_to carts_path
	end

	def destroy
	@cart_item = CartItem.find(params[:id])
	@cart_item.destroy
	redirect_to carts_path
	end


end