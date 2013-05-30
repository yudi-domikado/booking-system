class OrdersController < ApplicationController

	def index
    @orders = current_user.orders.all
	end

	def show
		@order = Order.find(params[:id]) 
	end

	def create
		Order.approve_cart(session_cart, current_user.id, params)
		redirect_to orders_path
	end
end

