module ExtAction
  module Base
  	extend ActiveSupport::Concern

  	included do
  		layout :custom_layout
      before_filter :check_profile
      respond_to :html, :xml, :json, :pdf, :js, :rss
  	end
    
    module ClassMethods
	    def authorize_controller opts = {}
	      options = opts.clone
	      options.delete(:skip)
	      load_and_authorize_resource( options )
	      skip_authorize_resource(only: opts[:skip]) if opts[:skip]
	      rescue_from CanCan::AccessDenied do |e|
	        flash[:alert] = e.message
	        redirect_to private_dashboard_path
	      end
	    end
    end

  	private
	    def page
	      params[:page]
	    end

	    def per_page
	      params[:per_page] || 20
	    end

	    def query_search
	      @query_search ||= params[:keywords] || ""
	    end

	    def custom_layout
	    	return 'private' if devise_controller? || request.path =~ /private/i
	    	'application'
	    end

	  	def session_cart
	  	  return session[:cart_id] if session[:cart_id]
	  	  session[:cart_id] = request.session_options[:id]	
	  	end

	    def after_sign_up_path_for(resource)
	      shared_redirection(resource)
	    end

	    def after_sign_in_path_for(resource)
	      shared_redirection(resource)
	    end

	    def after_sign_out_path_for(resource)
	      root_path
	    end

	    def complete_profile
	      return nil if current_user.complete_profile?
	      profile_private_users_path
	    end

	    def check_profile
	      if current_user 
	      	if !current_user.complete_profile? && params[:action] !~ /profile/i
	          flash[:alert] = "Please complete your profile, before continue."
	          redirect_to profile_private_users_path
	        elsif current_user.room_admin? || current_user.super_admin?
	        	gon.watch.total_pending_rooms = pending_rooms.count
	        	gon.watch.pending_rooms = pending_rooms_content 
	        end	
	      end
	    end

	    def pending_rooms
	      @pending_rooms ||= RoomOrder.pendings
	    end

	    def pending_rooms_content
	      @pending_rooms_content ||= (pending_rooms ? view_context.render(partial: 'private/shared/pending_rooms').to_s.html_safe : "")
	    end

	    def shared_redirection(resource=nil)
	      resource = current_user unless resource
	      complete_profile || stored_location_for(resource) || private_dashboard_path
	    end
  end
end