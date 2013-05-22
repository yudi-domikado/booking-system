class CartItem < ActiveRecord::Base
  # attr_accessible :title, :body
  attr_accessible :cart_id, :room_id, :check_in_date, :start_time, :end_time, :price
  belongs_to :cart
  belongs_to :room
  validate :check_time
  validates_presence_of :start_time
  validates_presence_of :end_time

  def check_time
  	if start_time.present?
  	  if start_time < Time.now
  	  	errors.add("Start Time", "should be greater than now")
  	  end
  	elsif end_time.present?
  	  if end_time < Time.now
  	  	errors.add("End Time", "should be greater than now")
  	  end
  	end
  	if start_time && end_time && start_time > end_time
  		errors.add("End Time", "should be greater than Start Time")
  	end
  end
end
