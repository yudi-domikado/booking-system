class Private::UsersController < InheritedResources::Base
  before_filter :authenticate_user!
  before_filter :sanitize_password
  authorize_controller class: "User"
  defaults resource_class: User, collection_name: 'users', instance_name: 'user'
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

	def profile	
		if current_user.update_attributes(params[:user])
      redirect_to shared_redirection
		else 
			flash[:alert] = current_user.errors.full_messages.to_sentence
		end if request.put?
	end

  protected
    def collection
      @users ||= end_of_association_chain.newest
      @users = @users.search_for(query_search).page(page).per(per_page)
    end

    def after_save(format)
	  	if @user.errors.empty?
      	flash[:notice] = "User has been #{params[:action]}d successfully"
        format.html { redirect_to (current_user.customer? ? edit_private_user_path(current_user) : private_users_path) }
      end
    end

    def sanitize_password
    	if params[:user]
    		params[:user].delete(:password) if params[:user][:password].blank?
    		params[:user].delete(:password_confirmation) if params[:user][:password_confirmation].blank?
    	end
    end

	# private
	#   def check_authority
	#   	@user ||= current_user.customer? ? current_user : (params[:id] ? User.find(params[:id]) : current_user)
	#   end

end