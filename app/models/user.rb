class User < ApplicationRecord
	validates :email, format: {with: /.*@.*\.../}, uniqueness: true, presence: true 
	validates :first_name, presence: true
	validates :last_name, presence: true


	has_many :users_recipes
	has_many :recipes, through: :users_recipes
	has_many :votes

	enum role: [:customer, :admin]

	has_secure_password

	scope :first_name, -> (first_name) { where("first_name ILIKE ?", "%#{first_name}%") }
end
