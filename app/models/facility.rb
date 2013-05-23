class Facility < ActiveRecord::Base
  attr_accessible :name, :price, :room_id , :quantity , :unlimited
  belongs_to :room
end
