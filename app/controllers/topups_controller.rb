class TopupsController < ApplicationController
	def index
	  @topups = Topup.all
	end
	def new
	  @topup = Topup.new
	end
	def create
	  @topup = Topup.new(params[:topup])
	  @topup.save
	  if @topup.valid?
	    redirect_to topups_path
	  else
	    render new_topup_path
	  end
	end
	def edit
	  @topup = Topup.find(params[:id])
	end
	def update
	  @topup = Topup.find(params[:id])
	  @topup.update_attributes(params[:topup])
	  redirect_to topups_path
	end
	def destroy
	  @topup = Topup.find(params[:id])
	  @topup.destroy
	  redirect_to topups_path
	end
end
