class User < ApplicationRecord
	validates :email, format: {with: /.*@.*\.../}, uniqueness: true, presence: true 
	validates :first_name, presence: true
	validates :last_name, presence: true
	validates :password, presence: true

	has_many :users_recipes
	has_many :recipes, through: :users_recipes

	has_secure_password
end
