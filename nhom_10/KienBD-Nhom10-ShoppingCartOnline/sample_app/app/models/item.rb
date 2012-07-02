class Item < ActiveRecord::Base
  attr_accessible :product_id, :quantity
  belongs_to :cart
  has_one :product
  validates :cart_id,presence: true
end
