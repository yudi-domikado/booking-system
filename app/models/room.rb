class Room < ActiveRecord::Base
  # attr_accessible :title, :body
  belongs_to :user
  belongs_to :room
  belongs_to :order
  attr_accessible :name, :description, :price, :picture, :user_id
  has_attached_file :picture, 
                    :styles => { :medium => "250x250>", :thumb => "100x100>" }, 
                    :default_url => "/images/missing.png"
end