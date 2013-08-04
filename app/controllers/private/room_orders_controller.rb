class Private::RoomOrdersController < InheritedResources::Base
  before_filter :authenticate_user!
  before_filter :protect_status, only: [:create, :update]
  authorize_controller class: "RoomOrder", except: [:checkout, :create]
  defaults resource_class: RoomOrder, collection_name: 'room_orders', instance_name: 'room_order'
  actions :all, except: [:show]

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
      @room_orders = end_of_association_chain.order_histories(current_user,"RoomOrder").search_for(query_search).page(page).per(per_page)
    end

    def model
	  	@model ||= (current_user.customer? ? current_user.room_orders : RoomOrder)
	  end

	  def cart
	  	@cart ||= RoomCart.find_or_create_by_session_id(session_cart)	
	  end

	  def sanitize_status
	  	if params[:room_order][:status]
	  		@room_order.status = params[:room_order][:status] 
	  		params[:room_order].delete(:status)
	  	end
	  end

	  def after_save(format)
	  	if @room_order.errors.empty?
      	flash[:notice] = "Booking room has been #{params[:action]}d successfully"
        format.html { redirect_to private_room_orders_path }
      end
    end

    def protect_status
    	unless (current_user.room_admin? || current_user.super_admin?)
    		if params[:room_order][:status] && params[:room_order][:status].to_s !~ /cancel/i
    			params[:room_order].delete(:status)
    		end
    		
    		if params[:room_order][:room_items_attributes]
    			params[:room_order][:room_items_attributes].map{|item| item.delete(:status) }
    		end
    	end if params[:room_order]
    end

end

