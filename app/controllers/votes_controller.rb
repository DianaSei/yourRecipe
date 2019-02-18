class VotesController < ApplicationController
	include SessionsHelper
	# skip_before_action :verify_authenticity_token


	# def upvote
	# 	@recipe = Recipe.find(params[:id])
	# 	@vote = Vote.new(recipe_id: params[:id], user_id: current_user.id)
	# 		byebug
			
	# 		vote_count = @recipe.votes.count

	# 	if @vote.save! 
	# 		vote_count +=1
	# 		{message: 'Successful', new_count: vote_count}.to_json
	# 	else
	# 		{message: 'Failed', new_count: vote_count}.to_json
	# 	end
	# end
end



