class Cart < ActiveRecord::Base
  # attr_accessible :title, :body
  attr_accessible :session_id
  has_many :cart_items
end
