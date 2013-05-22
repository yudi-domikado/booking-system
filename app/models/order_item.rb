class OrderItem < ActiveRecord::Base	
  belongs_to :room
  belongs_to :order
  attr_accessible :order_id , :start_time, :end_time, :check_in_date, :price, :room_id
  # validate :check_avilability

  # private 
  #   def check_availability
  #   	if where("start_time >= ? AND start_time < ?", self.start_time, self.end_time).present?
  #   		self.errors.add(:start_time, "is already used by another company")
  #   	end
  #   end

end