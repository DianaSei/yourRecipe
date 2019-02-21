class UsersRecipeController < ApplicationController
	def new
		userRecipe = UsersRecipe.new
	end

	#test

	def create
		userRecipe = UsersRecipe.new(user_id: params[:user_id], recipe_id: params[:id])
		if userRecipe.save
			flash[:success] = "You have new items in your favourites now! Go and check it!"
		end
	end
end
