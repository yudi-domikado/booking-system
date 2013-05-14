class Event < ActiveRecord::Base
  attr_accessible :starts_at, :ends_at, :title, :description , :room_id, :user_id
  belongs_to :room
  belongs_to :order
  belongs_to :user
  scope :before, lambda {|end_time| {:conditions => ["ends_at < ?", Event.format_date(end_time)] }}
  scope :after, lambda {|start_time| {:conditions => ["starts_at > ?", Event.format_date(start_time)] }}
  validate :check_tgl
  
  # need to override the json view to return what full_calendar is expecting.
  # http://arshaw.com/fullcalendar/docs/event_data/Event_Object/
  def as_json(options = {})
    {
      :id => self.id,
      :title => self.title,
      :description => self.description || "",
      :start => starts_at.rfc822,
      :end => ends_at.rfc822,
      :allDay => false,
      :recurring => false,
      :url => Rails.application.routes.url_helpers.event_path(id)
    }
    
  end
  
  def self.format_date(date_time)
    Time.at(date_time.to_i).to_formatted_s(:db)
  end
  def check_tgl
  if starts_at.present?
    if starts_at < Time.now
        errors.add("Start at", "cannot be oldest than date now")
      end
  elsif ends_at.present?
      if ends_at < Time.now
      errors.add("End at", "should be greater than date now")
      end
  end
      if starts_at && ends_at && starts_at > ends_at
      errors.add("Ends At", "should be greater than start date")
      end
  end

end