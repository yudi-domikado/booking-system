class CartItem < ActiveRecord::Base
  # attr_accessible :title, :body
  attr_accessible :cart_id, :room_id, :check_in_date, :start_time, :end_time, :price
  belongs_to :room
  belongs_to :cart
  validate :check_time
  validates_presence_of :start_time
  validates_presence_of :end_time

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
  end
end
