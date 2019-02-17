class RecipeController < ApplicationController
	include SessionsHelper
	skip_before_action :verify_authenticity_token

	def index
		@recipes = Recipe.where(reference_id: current_user.id)
	end

	def new
		@recipe = Recipe.new
	end

	def create
		@recipe = Recipe.new(recipe_params)
		@recipe.publisher = current_user.first_name
		@recipe.reference_id = current_user.id
		if @recipe.save
			redirect_to root_path
		end
	end

	def verify
		recipe = Recipe.find(params[:id])

		if recipe.verify == nil
			recipe.update(verify: true)
		end
			redirect_to root_path
	end

	def unverify
		recipe = Recipe.find(params[:id])
		if recipe.verify == nil
			recipe.update(verify: false)
		end
			redirect_to root_path	
	end

	def upvote
		@recipe = Recipe.find(params[:id])
		@vote = Vote.new(recipe_id: params[:id], user_id: current_user.id)
			
			vote_count = @recipe.votes.count

		if @vote.save! 
			vote_count +=1

			respond_to do |format|
		      format.json { message :'Successful'}
		      format.html { new_count :vote_count }
		   	end
		else
			respond_to do |format|
		      format.json { message :'Failed'}
		      format.html { new_count :vote_count }
		   	end
		end
	end

	private
	def recipe_params
		params.require(:recipe).permit(
		  :title, 
		  :ingredients,
		)	 
	end
	
end
