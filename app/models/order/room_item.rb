class Order::RoomItem < ActiveRecord::Base
  attr_accessible :check_in_date, :room_id, :status, :hour_start, :hour_end
  belongs_to :itemable, polymorphic: true
  scoped_search in: :user, on: [:name, :email]

  attr_accessor :hour_start, :hour_end
  
  before_validation :parse_time
  validate :check_availability

  belongs_to :room_order
  belongs_to :room
  before_create :prepare_creation 

  def self.new_by_item(cart_item)
    new({room_id:       cart_item.room_id,
         check_in_date: cart_item.check_in_date}).tap do |new_item|
      new_item.start_time = cart_item.start_time
      new_item.end_time = cart_item.end_time
    end
  end

  def self.check_presence(item)
    where(room_id: item.room_id).
    where(check_in_date: item.check_in_date).
    where("status NOT LIKE ?", Order::Status::CANCELED).
    where("(start_time <= ? AND end_time > ?) OR " + 
          "(start_time < ? AND end_time >= ?) OR " + 
          "(start_time > ? AND end_time < ?)", 
          item.start_time.to_i, item.start_time.to_i, 
          item.end_time.to_i,   item.end_time.to_i, 
          item.start_time.to_i, item.end_time.to_i).
    first
  end

  def self.validate_availability(item)
    unless item.errors.present?
      item.errors.add("Start hour", "is invalid and not empty") if item.start_time.blank?
      item.errors.add("End hour", "is invalid and should be greater than time now") if is_older?(item)
      item.errors.add("End hour", "is invalid and should be greater than Start hour") if is_wrong_end_time?(item)
      item.errors.add("Room", "is not registered, please refresh your browser") if item.room.blank?
    end
  end

  def self.is_older?(item)
    item.errors.blank? && item.end_time.present? && item.end_time.to_i < Time.now.to_i
  end

  def self.is_wrong_end_time?(item)
    item.errors.blank? && item.start_time && item.end_time && item.start_time > item.end_time
  end

  private 
    def parse_time
      self.start_time = Time.parse("#{self.check_in_date} #{self.hour_start}").to_i if self.hour_start.present?
      self.end_time = Time.parse("#{self.check_in_date} #{self.hour_end}").to_i if self.hour_end.present?
    end

    def check_availability
      self.amount = self.quantity.to_i * self.price.to_i
      self.class.validate_availability(self)
      
      if self.changes["start_time"] || self.changes["end_time"]
        room_item = self.class.check_presence(self)
        if room_item
          self.errors.add(room_item.room.name.titleize, "is already used by another company")
        end
      end
    end

    def prepare_creation
      self.status = Order::Status::PENDING
    end

end
