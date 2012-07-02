class AddNumberToCarts < ActiveRecord::Migration
  def change
    add_column :carts, :number, :integer
  end
end
