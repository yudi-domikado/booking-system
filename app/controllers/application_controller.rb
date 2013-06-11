class ApplicationController < ActionController::Base
  protect_from_forgery

	private
  
	def session_cart
	  return session[:cart_id] if session[:cart_id]
	  session[:cart_id] = request.session_options[:id]	
	end

end
