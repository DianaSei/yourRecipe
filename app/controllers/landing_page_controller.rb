class LandingPageController < ApplicationController
	include SessionsHelper
	require "json"
  	require "http"
  	require "jbuilder"
  	require "http/mime_type/adapter"

	def search
		url = "https://api.edamam.com/search"
	  	#Shows the search form if no paramaters are present

  	
	  	# if params[:ingredient].present? 

	  	# 	response = HTTP.get("https://www.food2fork.com/api/search?key=c77f33aaec7dc118f1c653b46b928385&q=chicken%20breast") 
	  	# 	@recipes_json = JSON.parse(response)
	  	# 	@recipe = @recipes_json["recipes"]

	  		
	  	# 	@recipe.each do |r|
	   #  			if Recipe.find_by(reference_id: r['recipe_id']).present?
	   # 			  	else
	  	#   			# If new, make a new entry
	   #  				Recipe.create(
	   #  					publisher: r['publisher'], 
	   #  					title: r['title'], 
	   #  					ingredients: r['ingredients'], 
	   #  					source_url: r['source_url'],
	   #  					image: r['image_url'],
	   #  					rank: r['social_rank'],
	   #  					reference_id: r['recipe_id'],
	   #  					verify: true
	   #  				)
	   # 				end
	   # 		end
	  		
	  	# end
	  	@recipes = Recipe.where(verify: true)
	  	
	end


	def index
		@users = User.all
		@recipes = Recipe.all

	  		
	end
  

end
