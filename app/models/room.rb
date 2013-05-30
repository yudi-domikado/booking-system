class Room < ActiveRecord::Base
  # attr_accessible :title, :body
  belongs_to :user
  belongs_to :room
  belongs_to :order
  belongs_to :cart
  has_many :events
  has_many :facilities
  attr_accessible :name, :description, :price, :picture, :user_id
  has_attached_file :picture, 
                    :styles => {:large => "693xauto>", :medium => "66x50>", :thumb => "150x150>" }, 
                    :default_url => "/assets/no_image.png"

	def self.search(search) #search yang didalam kurung adalah parameter yang di controller
	    if search
	      return where(['name LIKE ? OR price LIKE ? OR description LIKE ? ' , "%#{search}%","%#{search}%","%#{search}%"]) # dikasih pagar biar kecetak di sql
	    else
	      return find(:all)
	    end
	end
end