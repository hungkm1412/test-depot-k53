class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :pro_id
      t.string :name
      t.string :detail
      t.string :category
      t.float :price

      t.timestamps
    end
    add_index :products, [:pro_id, :created_at]
  end
end
