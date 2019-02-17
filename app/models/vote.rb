class Vote < ApplicationRecord
	# validates :recipe_id, uniqueness: {scope: :user}
	
	belongs_to :recipe
	belongs_to :user
end
