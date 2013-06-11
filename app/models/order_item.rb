class OrderItem < ActiveRecord::Base	
  belongs_to :room
  belongs_to :order
  attr_accessible :order_id , :start_time, :end_time, :check_in_date, :price, :room_id
  validate :check_availability

  private 
    def check_availability
      if self.start_time.blank?
        self.room.errors.add("Start time", "should be greater than now")
      end
      
      if self.end_time.present? && self.end_time < Time.now.to_i
        self.room.errors.add("End time", "should be greater than now")
      end
    
      if self.start_time && self.end_time && self.start_time > self.end_time
        self.room.errors.add("End time", "should be greater than Start Time")
      end

      if OrderItem.where(room_id: self.room_id).
                   where(check_in_date: self.check_in_date).
                   where("(start_time <= ? AND end_time >= ?) OR (start_time <= ? AND end_time >= ?) OR (start_time > ? AND end_time < ?)", 
                          self.start_time.to_i, self.start_time.to_i, self.end_time.to_i, self.end_time.to_i, self.start_time.to_i, self.end_time.to_i).
                   present?
        self.room.errors.add("room", "is already used by another company")
      end
    end
end
