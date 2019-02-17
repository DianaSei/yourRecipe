class Recipe < ApplicationRecord
	has_many :users_recipes 
	has_many :users, through: :users_recipes
	has_many :votes
end
