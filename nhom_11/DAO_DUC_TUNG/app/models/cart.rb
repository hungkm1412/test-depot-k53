class Cart < ActiveRecord::Base
  attr_accessible :status

  has_many :items, class_name: "CartItem"
  has_one :order

  def total_price
    items.all.map{|i| i.product.price * i.quantity }.reduce(:+)
  end
end
