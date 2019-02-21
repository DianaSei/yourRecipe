require 'rails_helper'

RSpec.describe Recipe, type: :model do
  context "custom_method" do
  	let (:params_1) {{id: 1, publisher: "customer_1", title: "title_1", rank: "rank_1"}}
    let (:params_2) {{id: 2, publisher: "customer_2", title: "title_2", rank: "rank_2"}} 
    let (:params_3) {{id: 3, first_name: "John", last_name: "Smith", email: "example@example.com", password: "123"}} 

    it "search_recipe_title - happy path" do 
        recipe_1 = Recipe.new(params_1).save
        recipe_2 = Recipe.new(params_2).save
        recipes = Recipe.all
        recipe = Recipe.where("title ILIKE ? ", "title_1")
        expect(recipe.length).to eq(1)
    end

    it "should give an error in search - unhappy path" do 
        recipe_1 = Recipe.new(params_1).save
        recipe_2 = Recipe.new(params_2).save
        recipes = Recipe.all
        recipe = Recipe.where("title ILIKE ? ", "title_1")
        expect(recipe.length).not_to eq(2)
    end

    it "checks the join table for fav_recipe - happy path" do
    	user = User.create(params_3)
    	recipe = Recipe.create(params_1)
    	user_recipe = UsersRecipe.new(user_id: user.id, recipe_id: recipe.id).save
    	fav_recipe = UsersRecipe.where(user_id: user.id, recipe_id: recipe.id).present?
    	expect(fav_recipe).to eq(true)
    end

    it "should give an error when checking fav_recipe - unhappy path" do
    	user = User.create(params_3)
    	recipe = Recipe.create(params_1)
    	user_recipe = UsersRecipe.new(recipe_id: recipe.id).save
    	fav_recipe = UsersRecipe.where(user_id: user.id, recipe_id: recipe.id)
    	expect(user_recipe = fav_recipe).not_to eq(true) 
    end
  end
end
