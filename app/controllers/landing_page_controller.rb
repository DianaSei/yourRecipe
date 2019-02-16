class LandingPageController < ApplicationController
	include SessionsHelper
	require "json"
  	require "http"

	def index
	url = "https://www.food2fork.com/api/search"
  	#Shows the search form if no paramaters are present

  	
  	if params[:ingredient].present? 

  		response = HTTP.get("https://www.food2fork.com/api/search")
  		@recipes = response.parse['businesses']
  		
  		
  		@recipes.each do |r|
  			
    			if Recipe.find_by(reference_id: r['recipe_id']).present?
   			  	else
  	  			# If new, make a new entry
    				Recipe.create(
    					publisher: r['publisher'], 
    					title: r['title'], 
    					ingredients: r['ingredients'], 
    					source_url: r['source_url'],
    					image: r['image_url'],
    					rank: r['social_rank'],
    					reference_id: r['recipe_id']
    				)
   			end
  		end
  	end
	end
  

end
