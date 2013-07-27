class Private::UsersController < ApplicationController
before_filter :authenticate_user!
	
	def index
	end

	def checkout
	  @cart = Cart.find_or_create_by_session_id(session_cart)	
	end

	def show
  	redirect_to rooms_path
	end

	def profile	
		if current_user.update_attributes(params[:user])
      redirect_to shared_redirection
		else 
			flash[:alert] = current_user.errors.full_messages.to_sentence
		end if request.put?
	end

end