class ApplicationController < ActionController::Base
  protect_from_forgery
  layout :custom_layout
  before_filter :check_profile
  
  private
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
      if current_user && !current_user.complete_profile?
        flash[:alert] = "Please complete your profile, before continue."
        redirect_to profile_private_users_path
      end if params[:action] !~ /profile/i
    end

    def shared_redirection(resource=nil)
      resource = current_user unless resource
      complete_profile || stored_location_for(resource) || private_dashboard_path
    end

    def self.authorize_controller opts = {}
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
