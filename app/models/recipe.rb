class Recipe < ApplicationRecord
	has_many :users_recipes 
	has_many :users, through: :users_recipes

	acts_as_votable
	mount_uploader :image, AvatarUploader
end
