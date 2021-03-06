class CreateUsersRecipes < ActiveRecord::Migration[5.2]
  def change
    create_table :users_recipes do |t|
      t.belongs_to :user, foreign_key: true
      t.belongs_to :recipe, foreign_key: true

      t.timestamps
    end
  end
end
