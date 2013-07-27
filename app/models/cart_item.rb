class CartItem < ActiveRecord::Base
  attr_accessor   :hour_start, :hour_end

  before_validation :parse_time
  

  with_options(presence: true) do |presence|
    presence.validates :start_time
    presence.validates :end_time
    presence.validates :title
    presence.validates :company_id
  end

  validate :check_time

  belongs_to :room
  belongs_to :cart
  belongs_to :facility
  belongs_to :company

  before_destroy :facilities


  delegate :title, to: :company, prefix: true, allow_nil: true

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
        self.errors.add("Company", "is not registered, please refresh your browser") if self.company.blank?
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
      OrderItem.where(room_id: self.room_id).
                where(check_in_date: self.check_in_date).
                where("(start_time <= ? AND end_time > ?) OR (start_time < ? AND end_time >= ?) OR (start_time > ? AND end_time < ?)", 
                      self.start_time, self.start_time, self.end_time, self.end_time, self.start_time, self.end_time).
                present?
    end

    def is_already_reserved?
      return false if self.errors.present?
      self.cart.cart_items.
          where(room_id: self.room_id).
          where(check_in_date: self.check_in_date).
          where(start_time: self.start_time).
          where(end_time: self.end_time).present?
    end

    def facilities
      Facility.where("id IN (?)", facility_ids.to_s.split(","))
    end
end
