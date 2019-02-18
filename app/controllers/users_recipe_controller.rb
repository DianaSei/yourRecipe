class UsersRecipeController < ApplicationController
	def new
		userRecipe = UsersRecipe.new
	end

	def create
		userRecipe = UsersRecipe.new(user_id: params[:user_id], recipe_id: params[:id])
			if userRecipe.save
			respond_to do |format|
		      format.js 
		   	end
		end
	end
end
