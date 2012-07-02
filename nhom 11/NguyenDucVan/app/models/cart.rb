class Cart < ActiveRecord::Base
  attr_accessible :total_price
	#validates_numericality_of :total_price, :greater_than => 0

	has_many :cart_items
end
