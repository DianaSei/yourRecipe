class SessionsController < ApplicationController
include SessionsHelper

	def new
	end
	
	def create
		user = User.find_by_email(params[:email])
	    if user && user.authenticate(params[:password])
	      sign_in(user)
	      flash[:success] = "Logged in!"
	      redirect_to root_url
	    else
	      flash[:primary] = "Email or password is invalid"
	      render "new"
	    end
 	end

 	def destroy
 		sign_out
 		flash[:primary] = "Logged out"
    	redirect_to root_url
 	end
end
