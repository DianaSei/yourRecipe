class UsersController < ApplicationController
	include SessionsHelper

	def new
		@user = User.new
	end

	def show
		@user = User.find(params[:id])
		@recipes = Recipe.where(reference_id: @user.id, verify: true)
		@my_recipes = Recipe.where(reference_id: @user.id)
	end

	def create
		@user = User.new(user_params)
	  	if @user.save
	  		flash[:success] = "Welcome to YourRecipe, please login now!"
	    	redirect_to root_path
	 	else
	 		flash[:warning] = "Sorry your email or password is invalid! Try again!"
	    	redirect_to root_path
	  	end
	end

	def index
		@users = User.first_name(params[:first_name]) if params[:first_name].present?
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
