class Private::CompaniesController < InheritedResources::Base
  before_filter :authenticate_user!
  authorize_controller class: "Company"
  defaults resource_class: Company, collection_name: 'companies', instance_name: 'compan'
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
      @companies = end_of_association_chain.newest.search_for(query_search).page(page).per(per_page)
    end

    def after_save(format)
	  	if @compan.errors.empty?
      	flash[:notice] = "Company has been #{params[:action]}d successfully"
        format.html { redirect_to private_companies_path }
      end
    end

end