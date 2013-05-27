class OrdersController < ApplicationController

	def index
    @orders = current_user.orders.all
	end

	def show
		@order = Order.find(params[:id]) 
	end

	def create
		Order.approve_cart(session_cart, current_user.id, params[:company], params[:department]) # <--- disini dijelaskan bahwa model Order memanggil metode Approve Cart ( dua metode )
		redirect_to orders_path
	end
end

