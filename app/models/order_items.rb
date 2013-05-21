class OrderItem < ActiveRecord::Base
  belongs_to :user
  belongs_to :order
  belongs_to :room
  attr_accessible :start_time, :end_time, :price, :room_id
end