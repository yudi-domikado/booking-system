class Order::RoomItem < ActiveRecord::Base
  attr_accessible :check_in_date, :end_time, :room_id, :start_time
  belongs_to :itemable, polymorphic: true

  validate :check_availability
  belongs_to :room_order
  belongs_to :room

  def self.new_by_item(cart_item)
    new({room_id:       cart_item.room_id,
         check_in_date: cart_item.check_in_date,
         start_time:    cart_item.start_time,
         end_time:      cart_item.end_time})
  end

  private 
    def check_availability
      if self.start_time.blank?
        self.errors.add("Start hour", "should be greater than now")
      end
      
      if self.end_time.present? && self.end_time < Time.now.to_i
        self.errors.add("End hour", "should be greater than now")
      end
    
      if self.start_time && self.end_time && self.start_time > self.end_time
        self.errors.add("End hour", "should be greater than Start Time")
      end

      room_item = Order::RoomItem.where(room_id: self.room_id).
                  where(check_in_date: self.check_in_date).
                  where("(start_time <= ? AND end_time >= ?) OR (start_time <= ? AND end_time >= ?) OR (start_time > ? AND end_time < ?)", 
                  self.start_time.to_i, self.start_time.to_i, self.end_time.to_i, self.end_time.to_i, self.start_time.to_i, self.end_time.to_i).first
      if room_item
        self.errors.add(room_item.room.name.titleize, "is already used by another company")
      end
    end

end
