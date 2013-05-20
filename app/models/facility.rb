class Facility < ActiveRecord::Base
  attr_accessible :name, :price, :room_id
  belongs_to :cart
  belongs_to :room
end
