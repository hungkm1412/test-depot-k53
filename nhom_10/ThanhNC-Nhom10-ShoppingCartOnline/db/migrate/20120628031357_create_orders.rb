class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.integer :product_id
      t.integer :user_id
      t.string :status
      t.string :phone_number
      t.string :address
      t.string :note

      t.timestamps
    end
    add_index :orders, [:product_id, :user_id, :created_at]
  end
end
