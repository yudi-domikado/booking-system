class OrdersController < ApplicationController

def index
@orders = Order.all
end

def show
@order = Order.find(params[:id])
end

def approve
# process pemindahan data dari cart ke order
# berdasarkan session id dari shopping cart dan user id yang login
Order.approve_cart(session_cart, current_user.id) # <--- disini dijelaskan bahwa model Order memanggil metode Approve Cart ( dua metode )
redirect_to orders_path
end
end