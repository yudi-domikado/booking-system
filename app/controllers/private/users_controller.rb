class Private::UsersController < ApplicationController
  before_filter :authenticate_user!
  authorize_controller class: "User"
  before_filter :check_authority
	
	def index
	end

	def show
  	redirect_to rooms_path
	end

	def update
	end

	def profile	
		if current_user.update_attributes(params[:user])
      redirect_to shared_redirection
		else 
			flash[:alert] = current_user.errors.full_messages.to_sentence
		end if request.put?
	end

	private
	  def check_authority
	  	@user ||= current_user.customer? ? current_user : (params[:id] ? User.find(params[:id]) : current_user)
	  end

end