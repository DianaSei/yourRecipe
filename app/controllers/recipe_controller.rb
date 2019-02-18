class RecipeController < ApplicationController
	include SessionsHelper
	skip_before_action :verify_authenticity_token

	def index
		@recipes = current_user.recipes
	end

	def new
		@recipe = Recipe.new
	end

	def create
		@recipe = Recipe.new(recipe_params)
		@recipe.publisher = current_user.first_name
		@recipe.reference_id = current_user.id
		if @recipe.save
			redirect_to user_path(current_user.id)
		end
	end

	def verify
		recipe = Recipe.find(params[:id])

		if recipe.verify == nil
			recipe.update(verify: true)
		end
			redirect_to admin_path
	end

	def unverify
		recipe = Recipe.find(params[:id])
		if recipe.verify == nil
			recipe.update(verify: false)
		end
			redirect_to admin_path
	end

	def upvote
		@recipe = Recipe.find(params[:id])
		@recipe.liked_by current_user

		respond_to do |format|
	      format.js 
	   	end
	   	
	end

	def admin
		@recipes = Recipe.where(verify: nil)
	end

	private
	def recipe_params
		params.require(:recipe).permit(
		  :title, 
		  :ingredients,
		  :description,
		  :image,
		)	 
	end
	
end
