class Vote < ApplicationRecord
  belongs_to :recipe
  belongs_to :user
  validates :recipe_id, uniqueness: {scope: :user}
  
end
