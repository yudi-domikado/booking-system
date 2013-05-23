class Facility < ActiveRecord::Base
  attr_accessible :name, :price, :room_id , :description
  belongs_to :room
end
