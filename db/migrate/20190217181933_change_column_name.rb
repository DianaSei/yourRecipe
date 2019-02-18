class ChangeColumnName < ActiveRecord::Migration[5.2]
  def change
  	rename_column :recipes, :source_url, :source 
  end
end
