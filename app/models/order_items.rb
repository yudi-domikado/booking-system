class OrderItem < ActiveRecord::Base
  belongs_to :user
  belongs_to :order
  belongs_to :room
  attr_accessible :check_in, :check_out, :price, :food_id
end