class CartItem < ActiveRecord::Base
  attr_accessible :cart_id, :product_id, :quantity

  validates_numericality_of :quantity, :greater_than => 0
  belongs_to :product
  belongs_to :cart
end
