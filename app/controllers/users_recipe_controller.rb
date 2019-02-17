class UsersRecipeController < ApplicationController
	def new
		userRecipe = UsersRecipe.new
	end

	def create
		userRecipe = UsersRecipe.new(user_id: params[:user_id], recipe_id: params[:id])
			if userRecipe.save
			redirect_to root_path
		end
	end
end
