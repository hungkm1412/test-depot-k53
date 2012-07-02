class RemoveUserIdFromCarts < ActiveRecord::Migration
  def up
    remove_column :carts, :user_id
  end

  def down
    add_column :carts, :user_id, :integer
  end
end
