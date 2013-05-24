class OrderItem < ActiveRecord::Base	
  belongs_to :room
  belongs_to :order
  attr_accessible :order_id , :start_time, :end_time, :check_in_date, :price, :room_id
  validate :check_availability

  private 
    def check_availability
      if start_time.present?
        self.start_time = Time.parse("#{self.check_in_date} #{self.start_time}")
        errors.add("Start Time", "should be greater than now") if self.start_time < Time.now
      end
      
      if end_time.present?
        self.end_time = Time.parse("#{self.check_in_date} #{self.end_time}")    
        errors.add("End Time", "should be greater than now") if self.end_time < Time.now
      end
    
      if start_time && end_time && start_time > end_time
        errors.add("End Time", "should be greater than Start Time")
      end

      #self.class --> CartItem.where

      if OrderItem.where(room_id: self.room_id).
                   where(check_in_date: check_in_date).
                   where("(start_time <= ? AND end_time > ?) OR (start_time < ? AND end_time >= ?) OR (start_time > ? AND end_time < ?)", 
                          self.start_time, self.start_time, self.end_time, self.end_time, self.start_time, self.end_time).
                   present?
        self.errors.add("room", "is already used by another company")
      end
      end
    end