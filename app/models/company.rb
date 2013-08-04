class Company < ActiveRecord::Base
  attr_accessible :logo, :title, :color
  has_attached_file :logo, 
                    :styles => {:large => "512x512>", :medium => "294x294>", :thumb => "150x150>" }, 
                    :default_url => "/assets/no_image.png"

  scoped_search on: [:title]
  scope :newest, order("companies.updated_at DESC")

end