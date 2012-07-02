class Cart < ActiveRecord::Base
  attr_accessible :product_id, :user_id, :number

  belongs_to :users

  validates :product_id, presence: true
  validates :user_id, presence: true
  VALID_NUM_REGEX = /[0-9]+/
  validates :number, presence: true, format: { with: VALID_NUM_REGEX }

  def sum
    sum = 0
    Cart.all.each {|n| sum += n.number*(Product.find(n.product_id).price)}
    return sum
  end

end
