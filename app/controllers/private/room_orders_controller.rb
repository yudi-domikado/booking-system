class Private::RoomOrdersController < InheritedResources::Base
  before_filter :authenticate_user!
  authorize_controller class: "RoomOrder", except: [:checkout, :create]
  defaults resource_class: RoomOrder, collection_name: 'orders', instance_name: 'order'

	def create
		
		unless params[:room_order]
			user_id = current_user.customer? ? current_user.id : nil
		  result = RoomOrder.approve_cart(session_cart, current_user.id, params)

			if result.blank? || (result && result.errors.present?)
				if result.blank?
					flash[:alert] = "<b>Error: </b> Your cart can not be processed, please try again"
				else
  				flash[:alert] = "<b>Error: </b>" + result.errors.full_messages.to_sentence.gsub(/Room items\s/i,"")
  			end
				cart
				render action: "checkout"
			else
				flash[:notice] = "Your booking rooms is processing. Please wait for approval."
			  redirect_to private_room_orders_path
			end

		else
      sanitize_status
      create! do |format|
      	after_save(format)
      end
		end
	end

	def update
		sanitize_status
		update! do |format|
      after_save(format)
    end
  end

	def checkout
	  flash[:alert] = "You have not booked any meeting room, please back to room reservation page." if cart.items.blank?
	end

	protected
    def collection
      @orders ||= end_of_association_chain.order_histories(current_user).search_for(query_search).page(page).per(per_page)
    end

    def model
	  	@model ||= (current_user.customer? ? current_user.room_orders : RoomOrder)
	  end

	  def cart
	  	@cart ||= RoomCart.find_or_create_by_session_id(session_cart)	
	  end

	  def sanitize_status
	  	if params[:room_order][:status]
	  		@order.status = params[:room_order][:status] 
	  		params[:room_order].delete(:status)
	  	end
	  end

	  def after_save(format)
	  	if @order.errors.empty?
      	flash[:notice] = "Booking room has been #{params[:action]}ed successfully"
        format.html { redirect_to private_room_orders_path }
      end
    end

end

