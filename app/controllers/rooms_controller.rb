class RoomsController < ApplicationController
	def index
		@rooms = Room.all
		@rooms = Room.search(params[:search])
		#abis itu di view index model controller bersangkutan
		# <%= text_field_tag :search, (params[:search]), :class => 'field' %>
	end

	def show
	    @facilities = Facility.all
		@room = Room.find(params[:id])
	end
end
