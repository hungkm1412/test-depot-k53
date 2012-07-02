class AddPhoneAndAddressToUsers < ActiveRecord::Migration
  def change
    add_column :users, :phone, :string
    add_column :users, :address, :text
  end
end

