class CartItem < ActiveRecord::Base
  # attr_accessible :title, :body
  attr_accessible :cart_id, :start_time, :end_time, :room_id
  belongs_to :cart
  belongs_to :room
  validates_presence_of :start_time
  validates_presence_of :end_time

end
