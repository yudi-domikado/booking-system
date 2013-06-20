class RoomsController < ApplicationController
  layout :custom

	def index
		@rooms = Room.search(params[:search])
	end

	def show
	  @facilities = Facility.all
    room
	end

  def info
    gon.watch.current_meeting = current_meeting_content
    gon.watch.next_meetings = next_meetings_content
  end

  private
    def room
      @room ||= Room.find(params[:id])
    end

    def current_meeting
      @current_meeting ||= room.with_current_meeting
    end

    def next_meetings
      @next_meetings ||= room.next_meetings(current_meeting)
    end

    def current_meeting_content
      current_meeting
      view_context.render(partial: 'rooms/status').to_s.html_safe if request.xhr?
    end

    def next_meetings_content
      view_context.render(partial: 'rooms/queue', collection: next_meetings).to_s.html_safe if request.xhr?
    end

    def custom
      return false if request.xhr?
      return "schedule" if params[:action] == "info"
      "application"
    end
end
