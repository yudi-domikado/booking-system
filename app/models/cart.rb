class Cart < ActiveRecord::Base
  # attr_accessible :title, :body
  attr_accessible :session_id , :price
  has_many :cart_items, dependent: :destroy


  def self.add_item(session_cart,params)
	  cart = find_or_create_by_session_id(session_cart)
	  cart_item               = cart.cart_items.new
    cart_item.room_id       = params[:room_id]
	  cart_item.check_in_date = params[:check_in_date]
	  cart_item.hour_start    = params[:hour_start]
	  cart_item.facility_ids  = params[:facility_ids].join(",") if params[:facility_ids].present?	
	  cart_item.hour_end      = params[:hour_end]
	  cart_item.total         = cart_item.price.to_i + cart_item.room.price.to_i
	  cart_item.save
	  cart_item
	end
	
end
