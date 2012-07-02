class Cart < ActiveRecord::Base
  attr_accessible :number, :product_id, :user_id
  belongs_to :user
  belongs_to :product
  validates :product_id, presence: true
  validates :user_id, presence: true
end
