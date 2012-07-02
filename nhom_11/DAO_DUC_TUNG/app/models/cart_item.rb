class CartItem < ActiveRecord::Base
  attr_accessible :product_id, :cart_id, :quantity

  before_save :default_quantity

  belongs_to :cart
  belongs_to :product

  def default_quantity
    if quantity.nil? or quantity == 0
      quantity = 1
    end
  end
end
