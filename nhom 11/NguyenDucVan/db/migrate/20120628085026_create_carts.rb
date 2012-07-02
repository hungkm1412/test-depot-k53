class CreateCarts < ActiveRecord::Migration
  def change
    create_table :carts do |t|

    	t.decimal :total_price

      t.timestamps
    end
  end
end
