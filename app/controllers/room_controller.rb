class RoomController < ApplicationController
  layout :custom

  def show
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
      view_context.render(partial: 'room/status').to_s.html_safe
    end

    def next_meetings_content
      next_meetings ? view_context.render(partial: 'room/queue').to_s.html_safe : ""
    end

    def custom
      return false if request.xhr?
      "schedule"
    end
end
