class CartsController < ApplicationController

   def index
    @cart = Cart.find_or_create_by_session_id(session_cart)
   end

   def create
    @cart = Cart.find_or_create_by_session_id(session_cart)
    @cart_item = @cart.cart_items.find_or_initialize_by_room_id(params[:room_id])
    @cart_item.check_in = params[:check_in]
    @cart_item.check_out = params[:check_out]
    @cart_item.price = @cart_item.room.price
    @cart_item.save
    if @cart_item.valid?
      flash[:notice]="Succesfully add to cart"

    else
      flash[:alert]="#{@cart_item.errors.full_messages.to_sentence}"
    end
      redirect_to carts_path
            
   end

   private
    def session_cart
    return session[:cart_id] if session[:cart_id]
    session[:cart_id] = request.session_options[:id]
   end
end
