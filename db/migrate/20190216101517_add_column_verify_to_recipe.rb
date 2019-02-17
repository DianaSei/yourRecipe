class AddColumnVerifyToRecipe < ActiveRecord::Migration[5.2]
  def change
    add_column :recipes, :verify, :boolean
  end
end
