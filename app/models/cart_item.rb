class CartItem < ActiveRecord::Base
  # attr_accessible :title, :body
  attr_accessible :check_in, :check_out, :room_id
  belongs_to :cart
  belongs_to :room
  validate :check_room
  validates_presence_of :check_in
  validates_presence_of :check_out

  def check_room
  	if check_in.present?
  	  if check_in < Time.now
  	  	errors.add("Check In", "should be greater than now")
  	  end
  	elsif check_out.present?
  	  if check_out < Time.now
  	  	errors.add("Check Out", "should be greater than now")
  	  end
  	end
  	if check_in && check_out && check_in > check_out
  		errors.add("Check Out", "should be greater than check in")
  	end
  end
end
