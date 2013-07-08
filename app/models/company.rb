class Company < ActiveRecord::Base
  attr_accessible :logo, :title
  has_attached_file :logo, 
                    :styles => {:large => "512x512>", :medium => "294x294>", :thumb => "150x150>" }, 
                    :default_url => "/assets/no_image.png"
end