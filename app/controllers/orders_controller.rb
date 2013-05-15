class OrdersController < ApplicationController

	def index
		#@orders = Order.all 
    @orders = current_user.orders.all
	end
# ACTIVE RECORD QUERY INTERFACE

# dalam mempermudah pemanggilan view dan lain2 ada macam cara.

# Yang harus diperhatikan relasi dalam model seperti has_many and belongs_to

# misalkan user dan order

# user has many orders , order belongs to user . Pemanggilanya adalah :

# current_user.orders
# order.user

# @orders = current_user.orders.all <-- controller ( berarti manggil order yang dimiliki user saat ini )

	def show
		@order = Order.find(params[:id]) 
    # @order.search ( gak bisa )
    # tapi klo panggilnya
    # Order.search ( baru bisa )
    # karena di dalam class Order
    # method search menggunakan def self.search bukan def search
	end

  # Order.search

  # class Order < ActiveRercord::Base
     
  #    # jika ada method yang menggunakan self. 
  #    # maka disebut class method
  #    # artinya method tersebut bisa menjalan semua method dari class tersebut
  #    # tanpa harus membuat / initialize si method (.new)
  #    def self.search

  #    end
  # end


	def create
		# process pemindahan data dari cart ke order
		# berdasarkan session id dari shopping cart dan user id yang login juga komen dari form order
		Order.approve_cart(session_cart, current_user.id, params[:comment]) # <--- disini dijelaskan bahwa model Order memanggil metode Approve Cart ( dua metode )
		redirect_to orders_path
	end
end

 

  #Di Controller
  # Call back : Fungsi yang akan dijalankan untuk suatu event atau kondisi
  # Before_filter : Menjalankan method yang dimaksud sebelum action yang dituju dijalankan
  # Callback Controller <--- kalo baca di ruby dokumen
  # Class UserController 
  #     only setelah filter dll misalkan before_filter :authenticate_user! , 
  #     only [:index] berarti hanya dijalankan di index kalo Except
  #     except [:index] berarti dijalankan kecuali di index
  # 		before_filter :authenticate_user! <--- menjalankan authenticate user terlebih dahulu
  #     prepend_before_filter  :search_user! 
  #append (menambahkan setelah kondisi)
  #prepend ( menambahkan sebelum kondisi) <-- maka prepend_before_filter SELALU jalan sebelum before_filter
  # 		def index
  # 			puts "Say Hi"
  # 		end


  # 		def authenticate_user!
  # 			puts "Hello"
  # 		end
  #     
  #     def search_user
  #       puts "cari user"
  #     end
  # end
  # ONLY == IF , EXCEPT == UNLESS 
  # maka jika dijalankan users/index hasilnya adalah cari user hello say hi