class RoomsController < ApplicationController
	def index
		@rooms = Room.all
		@rooms = Room.search(params[:search])
	end

	def show
	    @facilities = Facility.all
		@room = Room.find(params[:id])
	end
end
