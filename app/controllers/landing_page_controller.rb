class LandingPageController < ApplicationController
	include SessionsHelper
	require "json"
  	require "http"
  	require "jbuilder"
  	require "http/mime_type/adapter"

	def search
		url = "https://api.edamam.com/search"
	  	#Shows the search form if no paramaters are present

  	
	  	if params[:ingredient].present? 

	  		ingredient = {title: params[:ingredient] }
	  		response = HTTP.get("https://www.food2fork.com/api/search?key=#{ENV['FOOD_2_FORK_API_KEY']}&q=#{params[:ingredient]}") 
	  		@recipes_json = JSON.parse(response)
	  		@recipe = @recipes_json["recipes"]

	  		
	    	@recipes =[]
	  		@recipe.each do |r|
	    			if Recipe.find_by(reference_id: r['recipe_id']).present?
	    				@old_recipe = Recipe.find_by(reference_id: r['recipe_id'])
	    				@recipes << @old_recipe
	   			  	else
	  	  			# If new, make a new entry
	    				@new_recipe = Recipe.create(
	    					publisher: r['publisher'], 
	    					title: r['title'], 
	    					ingredients: r['ingredients'], 
	    					source: r['source_url'],
	    					picture: r['image_url'],
	    					rank: r['social_rank'],
	    					reference_id: r['recipe_id'],
	    					verify: true
	    				)

	    				@recipes << @new_recipe
	   				end
	   		end
	  	end
	  	@users_recipes = UsersRecipe.all
	end


	def index
		@users = User.all
		@recipes = Recipe.all		
	end
  

end
