class RoomOrder < Order
  extend FriendlyId
  friendly_id :code, use: :slugged

	has_many :room_items, class_name: "Order::RoomItem", dependent: :destroy
  attr_accessible :room_items_attributes
  accepts_nested_attributes_for :room_items
  
  scoped_search in: :room_items, on: {room: :name}

  def self.cart_class
    RoomCart
  end

  def items
  	self.room_items
  end

  def self.approve_cart(session_id, user_id, params)
  	cart = cart_class.find_by_session_id(session_id)
  	return unless cart 
  	create do |order|
    	order.user_id = user_id 
      order.status = Order::Status::PENDING
      order.amount = cart.room_items.sum(:amount)
      order.order_at = Time.now
    	cart.room_items.each do |cart_item|
    		item = order.room_items.new_by_item(cart_item)
        item.quantity = cart_item.quantity
        item.price    = cart_item.price
        item.title    = cart_item.title
    		item.amount   = item.quantity * item.price
    		order.room_items << item
    		item.errors.messages.each do |k,v|
    			if order.errors.messages[k]
            order.errors.messages[k] << v
            order.errors.messages[k].uniq!
          else
          	order.errors.messages[k] = v
          end
    		end if item.errors.any?
    	end
      cart.destroy if order.valid?
  	end
  end

end