class RegistrationsController < Devise::RegistrationsController
	    skip_before_action :require_no_authentication

	def new
	    build_resource({})
	    yield resource if block_given?
	    if session[:user]
	      resource.email = session[:user]["email"]
	      resource.first_name = session[:user]["first_name"]
	      resource.last_name = session[:user]["last_name"]
	      resource.role = session[:user]["role"]
	    end
	    respond_with resource
  	end
  
	def create
		if current_user and current_user.role == "admin"
			build_resource(sign_up_params)
			if resource.save
				redirect_to "/users"
			else
		  		clean_up_passwords resource
		  		flash[:error] = resource.errors
		  		#respond_with resource, location: '/users/new'
		  		redirect_to "/users/new"
		  	end
	  	else
	  		flash[:notice] = "You are not authorised to create a user. Please contact the admin."
	    	redirect_to '/'
	  	end
	end

end
