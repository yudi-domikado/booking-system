class CartsController < ApplicationController  
  def index
    @cart = Cart.find_or_create_by_session_id(session_cart)
  end

  def create
    @cart_item = Cart.add_item(session_cart,params)
    flash[:alert] = @cart_item.errors.full_messages.uniq.to_sentence unless @cart_item.valid? 
    redirect_to carts_path  
  end

end
