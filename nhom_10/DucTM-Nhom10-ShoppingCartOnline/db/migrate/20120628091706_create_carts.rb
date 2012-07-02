class CreateCarts < ActiveRecord::Migration
  def change
    create_table :carts do |t|
      t.integer :number
      t.integer :user_id
      t.integer :product_id

      t.timestamps
    end
    add_index :carts, [:user_id, :product_id, :created_at]
  end
end
