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

	def edit
		@recipe = Recipe.find(params[:id])
	end

	def update
		recipe = Recipe.find(params[:id])
		recipe.update(recipe_params)
		recipe.save
		redirect_to user_path(current_user.id)
	end
		
	def destroy
		recipe = Recipe.find(params[:id])
		Recipe.check_fav_recipe(recipe.id)
		if recipe.destroy
			redirect_to user_path(current_user.id)
		else 
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
		# @vote = Vote.new(recipe_id: @recipe.id, user_id: current_user.id)
		# vote = current_user.votes.new(recipe_id: @recipe.id)
			# byebug
			# vote_count = @recipe.votes.count


		if current_user.votes.create(recipe_id: @recipe.id)
			# vote_count +=1
			
        	render json: {'message': 'Successful', 'new_count': @recipe.votes.count}

        else
        	render json: {'message': 'Failed', 'new_count': @recipe.votes.count}

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
