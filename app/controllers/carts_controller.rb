class CartsController < ApplicationController  
  
  def index
    cart
  end

  def create
    @cart_item = cart.add_item!(params)
    flash[:alert] = @cart_item.errors.full_messages.uniq.to_sentence if @cart_item.errors.present? 
    respond_to do |format|
      format.js
    end
  end

  def destroy
	  @cart_item = cart.cart_items.find(params[:id])
    @cart_item.destroy if @cart_item
    respond_to do |format|
      format.js
    end
  end

  def cart
    @cart ||= Cart.find_or_create_by_session_id(session_cart)
  end

end
