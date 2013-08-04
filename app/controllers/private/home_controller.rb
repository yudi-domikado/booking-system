class Private::HomeController < ApplicationController
	before_filter :authenticate_user!
	def show
	end

	def total_pending_booking_rooms
		gon.watch.total_pending_rooms = pending_rooms.count     	
	end

	def pending_booking_rooms
		gon.watch.pending_rooms = pending_rooms_content 
	end
end