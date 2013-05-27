class CartItem < ActiveRecord::Base
  # attr_accessible :title, :body
  attr_accessible :cart_id, :room_id, :check_in_date, :start_time, :end_time, :price , :facility_ids , :total
  belongs_to :room
  belongs_to :cart
  belongs_to :facility
  validate :check_time
  validates_presence_of :start_time
  validates_presence_of :end_time
  before_destroy :facilities

  def check_time

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

  def facilities
    Facility.where("id IN (?)", facility_ids.to_s.split(","))
  end
end
