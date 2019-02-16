class CreateRecipes < ActiveRecord::Migration[5.2]
  def change
    create_table :recipes do |t|

		t.string :publisher 
		t.string :title
		t.string :ingredients 
		t.string :source_url 
		t.string :image
		t.string :rank 
		t.string :reference_id 
      	t.timestamps
    end
  end
end
