class RoomOrder < Order
  extend FriendlyId
  friendly_id :code, use: :slugged

	has_many :room_items, class_name: "Order::RoomItem", dependent: :destroy

  attr_accessible :room_items_attributes
  accepts_nested_attributes_for :room_items, reject_if: :all_blank, allow_destroy: true
  
  after_validation :count_amount
  validates :room_items, presence: true
  validates :user_id, presence: true
  default_scope includes([{:room_items => :room}, {:user => :company}])

  after_save :after_saved

  def self.cart_class
    RoomCart
  end

  def self.pendings
    newest_orders.where("orders.status LIKE ? OR orders.status IS NULL", "%pending%")
  end

  def items
  	self.room_items
  end

  def self.approve_cart(session_id, user_id, params)
  	cart = cart_class.find_by_session_id(session_id)
  	return unless cart 
  	create do |order|
    	order.user_id = user_id
    	cart.room_items.each do |cart_item|
    		item = order.room_items.new_by_item(cart_item)
        item.quantity = cart_item.quantity
        item.price    = cart_item.price
        item.title    = cart_item.title
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

  private
    def count_amount
      self.amount = self.room_items.sum(:amount)
    end

    def after_saved
      if self.approved?
        self.room_items.where("status IS NULL OR status NOT IN (?)", [Order::Status::APPROVED, Order::Status::CANCELED]).each do |item|
          item.status = Order::Status::APPROVED 
          item.save(validate: false)
        end 
      elsif self.canceled?
        self.room_items.where("status IS NULL OR status NOT IN (?)", [Order::Status::CANCELED]).each do |item|
          item.status = Order::Status::CANCELED 
          item.save(validate: false)
        end 
      end
    end


end