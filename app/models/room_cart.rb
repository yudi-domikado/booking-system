class RoomCart < Cart
  has_many :room_items, class_name: "Cart::RoomItem", dependent: :destroy
  alias :items :room_items
  
  def self.add_item(session_cart,params)
    cart = find_or_create_by_session_id(session_cart)
    cart.add_item!(params)
  end

  def add_item!(params)
    room = Room.find(params[:room_id])
    unless room
      room_items.new.tap do |cart_item|
        cart_item.errors.add("Room", "is not registered. Please refresh your browser")
      end
    else
      room_items.new.tap do |cart_item|
        cart_item.quantity      = 1
        cart_item.price         = room.price
        cart_item.room_id       = room.id
        cart_item.title         = params[:title]
        cart_item.check_in_date = params[:check_in_date]
        cart_item.hour_start    = params[:hour_start]
        cart_item.hour_end      = params[:hour_end]
        cart_item.amount        = cart_item.quantity * cart_item.price
        cart_item.save
      end
    end
  end

end