class OrderItem < ActiveRecord::Base
  belongs_to :user
  belongs_to :order
  belongs_to :room
  attr_accessible :quantity, :price, :food_id
end