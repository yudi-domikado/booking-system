class Room < ActiveRecord::Base
  # attr_accessible :title, :body
  belongs_to :user
  belongs_to :room
  belongs_to :order
  belongs_to :cart
  has_many :events
  attr_accessible :name, :description, :price, :picture, :user_id
  has_attached_file :picture, 
                    :styles => { :medium => "250x250>", :thumb => "150x150>" }, 
                    :default_url => "/images/missing.png"
end