class CreateCarts < ActiveRecord::Migration
  def change
    create_table :carts do |t|
      t.integer :user_id
      t.integer :total_value

      t.timestamps
    end
  add_index :carts, [:user_id, :created_at],unique: true
  end
end
