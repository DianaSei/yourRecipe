class UsersController < ApplicationController
	def new
		@user = User.new
	end

	def show
		@user = current_user
		@recipes = @user.recipes
	end

	def create
		@user = User.new(user_params)
	  	if @user.save
	  		flash[:success] = "Welcome to YourRecipe"
	    	redirect_to root_path
	 	else
	 		flash[:warning] = "Sorry your email or password is invalid! Try again!"
	    	redirect_to root_path
	  	end
	end

	

	private 

	def user_params
		params.require(:user).permit(
			:first_name, 
			:last_name, 
			:email, 
			:password)
	end 
end
