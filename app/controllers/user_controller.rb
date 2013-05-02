class UserController < ApplicationController
	before_filter :authenticate_user
	def checkout
		@cart = Cart.find_or_create_by_session_id(session_cart)
	end
    private
       def session_cart
       	return session[:cart_id] if session[:cart_id]
       	session[:cart_id] = request.session_options[:id]
    end
end
