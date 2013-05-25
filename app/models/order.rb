class Order < ActiveRecord::Base
  attr_accessible :user_id, :ammount, :company, :department
  belongs_to :user
  has_many :order_items, dependent: :destroy

  def self.approve_cart(session_id, user_id, company, department)
  	cart = Cart.find_by_session_id(session_id)
  	return unless cart 
  	create do |order|
    	order.user_id = user_id 
      order.ammount = 0
      order.company = company
      order.department = department
    	cart.cart_items.each do |cart_item|
        order.ammount += cart_item.price
    		order.order_items.new({room_id: cart_item.room_id,
                               price: cart_item.price,
                               check_in_date: cart_item.check_in_date,
                               start_time: cart_item.start_time,
                               end_time: cart_item.end_time})
    	end
      cart.destroy
  	end
  end

end