class Cart::RoomItem < ActiveRecord::Base
  attr_accessor :hour_start, :hour_end

  before_validation :parse_time

  with_options(presence: true) do |presence|
    presence.validates :start_time
    presence.validates :end_time
    presence.validates :title
  end

  validate :check_time
  belongs_to :room_cart
  belongs_to :room

  def parse_time
    self.start_time = Time.parse("#{self.check_in_date} #{self.hour_start}").to_i if self.hour_start.present?
    self.end_time = Time.parse("#{self.check_in_date} #{self.hour_end}").to_i if self.hour_end.present?
  end

  private
    def check_time
      unless self.errors.present?
        self.errors.add("Start hour", "is invalid and not empty") if self.start_time.blank?
        self.errors.add("End hour", "is invalid and should be greater than time now") if is_older?
      	self.errors.add("End hour", "is invalid and should be greater than Start hour") if is_wrong_end_time?
        self.errors.add("Room", "is already used by another company") if is_already_booked?
        self.errors.add("You", "have booked the room, please complete your order") if is_already_reserved?
        self.errors.add("Room", "is not registered, please refresh your browser") if self.room.blank?
      end
      return self.errors.blank?
    end

    def is_older?
      self.errors.blank? && self.end_time.present? && self.end_time.to_i < Time.now.to_i
    end

    def is_wrong_end_time?
      self.errors.blank? && self.start_time && self.end_time && self.start_time > self.end_time
    end

    def is_already_booked?
      return false if self.errors.present?
      Order::RoomItem.where(room_id: self.room_id).
                      where(check_in_date: self.check_in_date).
                      where("(start_time <= ? AND end_time > ?) OR (start_time < ? AND end_time >= ?) OR (start_time > ? AND end_time < ?)", 
                            self.start_time, self.start_time, self.end_time, self.end_time, self.start_time, self.end_time).
                      present?
    end

    def is_already_reserved?
      return false if self.errors.present?
      Cart::RoomItem.where(room_id: self.room_id).
                     where(room_cart_id: self.room_cart_id).
					           where(check_in_date: self.check_in_date).
					           where(start_time: self.start_time).
					           where(end_time: self.end_time).present?
    end

end
