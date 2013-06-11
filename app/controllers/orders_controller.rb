class OrdersController < ApplicationController

	def index
    @orders = current_user.orders.all
	end

	def show
		@order = Order.find(params[:id]) 
	end

	def create
		result = Order.approve_cart(session_cart, current_user.id, params)
		if result && !result.valid?
			flash[:notice] = result.errors.full_messages
		end
		redirect_to orders_path
	end
end

