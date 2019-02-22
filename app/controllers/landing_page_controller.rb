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

	  		ingredient = params[:ingredient] 
	  		response = HTTP.get("https://www.food2fork.com/api/search?key=#{ENV['FOOD_2_FORK_API_KEY']}&q=#{params[:ingredient]}") 
	  		@recipes_json = JSON.parse(response)
	  		@recipe = @recipes_json["recipes"]
	  		

	    	@recipes =[]
	    	my_recipes = Recipe.search(ingredient)
	    	my_recipes.each do |my_r|
	    		@recipes << my_r
	    	end

	    	if @recipe != nil 
		  		@recipe.each do |r|

	    			if Recipe.find_by(reference_id: r['recipe_id']).present?
	    				@old_recipe = Recipe.find_by(reference_id: r['recipe_id'])
	    				@recipes << @old_recipe	   				
	   			  	else
	  	  			# If new, make a new entry
	    				@new_recipe = Recipe.new(
	    					publisher: r['publisher'], 
	    					title: r['title'], 
	    					ingredients: r['ingredients'], 
	    					source: r['source_url'],
	    					picture: r['image_url'],
	    					rank: r['social_rank'],
	    					reference_id: r['recipe_id'],
	    					verify: true
	    				)

	    				@new_recipe.save

	    				@recipes << @new_recipe
	   				end
		   		
		   		end
		   	else 
		   		@recipes = Recipe.all
		   		flash[:warning] = "Seems like our provider went down or there is no such ingredient! There are some suggestions for you from YourRecipe!"
	   		end
	   		
	  		@users_recipes = UsersRecipe.all
	  		@votes = Vote.all
	  	end
	end


	def index
		@users = User.all
		@recipes = Recipe.all		
	end
  

end
