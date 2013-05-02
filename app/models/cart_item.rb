class CartItem < ActiveRecord::Base
  # attr_accessible :title, :body
  attr_accessible :check_in, :check_out, :room_id
  belongs_to :cart
  belongs_to :room
end
