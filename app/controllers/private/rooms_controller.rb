class Private::RoomsController < InheritedResources::Base
  before_filter :authenticate_user!
  authorize_controller class: "Room"
  defaults resource_class: Room, collection_name: 'rooms', instance_name: 'room'
  actions :all, except: [:show]

  def create
    create! do |format|
    	after_save(format)
    end
	end

	def update
		update! do |format|
      after_save(format)
    end
  end

  protected
    def collection
      @rooms ||= end_of_association_chain
      @rooms = @rooms.search_for(query_search).page(page).per(per_page)
    end

    def after_save(format)
	  	if @room.errors.empty?
      	flash[:notice] = "Room has been #{params[:action]}d successfully"
        format.html { redirect_to private_rooms_path }
      end
    end

end