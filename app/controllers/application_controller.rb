class ApplicationController < ActionController::Base
  protect_from_forgery

  # before_filter :trace_session_id

  # def trace_session_id
  # 	logger.info "-------------------------------"
  # 	logger.info request.session_options[:id]
  # 	logger.info "-------------------------------"
  # end

  #buat testing id session dari browser

	private
	def session_cart
	  return session[:cart_id] if session[:cart_id]
	  session[:cart_id] = request.session_options[:id]	
	  #penjelasan method - > cart_id null maka cart_id dimasukan session_id kalo sudah ada dari awal di return kembali
	end


  #cara untuk membuat method untuk share ke anak2nya 
end
