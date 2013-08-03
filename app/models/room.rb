class Room < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, use: :slugged
  
  attr_accessible :name, :description, :price, :picture, :user_id
  
  has_attached_file :picture, 
                    :styles => {:large => "693xauto>", :medium => "66x50>", :thumb => "150x150>" }, 
                    :default_url => "/assets/no_image.png"
  
  belongs_to :user
  belongs_to :room
  belongs_to :order
  belongs_to :cart

  has_many :events
  has_many :facilities
  has_many :order_items, class_name: "Order::RoomItem", dependent: :destroy

	def self.search(search)
    find(:all) unless search
    where(3.times.map{"%#{search}%"}.unshift(search_condition))
	end

  def self.search_condition
    "name LIKE ? OR price LIKE ? OR description LIKE ?"
  end

  def with_current_meeting(time=Time.now)
    order_items.
    where(check_in_date: time.to_date).
    where(4.times.map{time.to_i}.unshift(booked_condition)).first
  end

  def next_meetings(current_meeting=nil, limit=2)
    current_meeting = with_current_meeting if current_meeting.blank?
    end_time = current_meeting ? current_meeting.end_time : Time.now
    
    order_items.
    where(check_in_date: (current_meeting ? current_meeting.check_in_date : Date.today)).
    where("start_time >= ? AND end_time >= ?", end_time.to_i, end_time.to_i).order("start_time ASC").limit(limit)
  end

  def booked_condition
    "(start_time <= ? AND end_time >= ?) OR (start_time > ? AND end_time < ?)"
  end
  
end