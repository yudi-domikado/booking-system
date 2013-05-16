class Order < ActiveRecord::Base
  attr_accessible :user_id
  belongs_to :user
  has_many :order_items, dependent: :destroy

  def self.approve_cart(session_id, user_id)
  	#check apakah cart dengan session_id yang diberikan ada atau tidak
  	cart = Cart.find_by_session_id(session_id)
  	return unless cart # kalo gak ada, kembalikan dengan hasil yang kosong
  	#klo ada maka buat order baru
  	create do |order|
    	order.user_id = user_id #daftarkan siapa pemilik order
     	# looping cart item untuk menjumlahkan total yang akan dibayar
    	# dan pindahkan cart item ke order item
    	cart.cart_items.each do |cart_item|
    		order.order_items.new({room_id: cart_item.room_id,
                               price: cart_item.price,
                               check_in: cart_item.check_in,
                               check_out: cart_item.check_out})
    	end
      cart.destroy
  	end
  end
end