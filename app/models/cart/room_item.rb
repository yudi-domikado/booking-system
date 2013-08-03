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
      Order::RoomItem.validate_availability(self)
      self.errors.add("You", "have booked the room, please complete your order") if is_already_reserved?
      self.errors.add("Room", "is already used by another company") if is_already_booked?
      return self.errors.blank?
    end

    def is_already_booked?
      return false if self.errors.present?
      Order::RoomItem.check_presence(self)
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
