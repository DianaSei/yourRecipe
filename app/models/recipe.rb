class Recipe < ApplicationRecord
	has_many :users_recipes 
	has_many :users, through: :users_recipes
	has_many :votes

	mount_uploader :image, AvatarUploader

	def self.check_fav_recipe(recipe_id)
		fav_recipe = UsersRecipe.find_by(recipe_id: recipe_id)
		if fav_recipe != nil
			fav_recipe.destroy
		end
	end

	def self.search(search)
		recipes = Recipe.where("title ILIKE ?", "%#{search}%")
		my_recipes = recipes.where(source: nil, verify: true)
	end
end
