class AddIndexToProductsName < ActiveRecord::Migration
  def change
  	add_index :products, :name, unique: true
  end
end
