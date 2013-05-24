class OrderItem < ActiveRecord::Base	
  belongs_to :room
  belongs_to :order
  attr_accessible :order_id , :start_time, :end_time, :check_in_date, :price, :room_id
  validate :check_availability

  private 
    def check_availability
    	if OrderItem.where(room_id: self.room_id).
                 where(check_in_date: check_in_date).
                 where("(start_time <= ? AND end_time > ?) OR (start_time < ? AND end_time >= ?) OR (start_time > ? AND end_time < ?)", 
                        self.start_time, self.start_time, self.end_time, self.end_time, self.start_time, self.end_time).present?
								# menggunakan sql query untuk nested conditions
								#

        self.errors.add("room", "is already used by another company")
      end
    end
end