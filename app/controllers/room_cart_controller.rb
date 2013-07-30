class RoomCartController < ApplicationController  
  def create
    @cart_item = cart.add_item!(params)
    flash[:alert] = @cart_item.errors.full_messages.uniq.to_sentence if @cart_item.errors.present? 
    respond_to do |format|
      format.js
    end
  end

  def destroy
    @cart_item = cart.room_items.find(params[:id])
    @cart_item.destroy if @cart_item
    respond_to do |format|
      if request.xhr? || params[:format] == "js"
        format.js
      else
        format.html {redirect_to checkout_private_room_orders_path}
      end
    end
  end

  private
    def cart
      @cart ||= RoomCart.find_or_create_by_session_id(session_cart)
    end
end