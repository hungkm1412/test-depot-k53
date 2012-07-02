class Product < ActiveRecord::Base
  attr_accessible :category_id, :name, :price
  belongs_to :category
  
  validates :category_id, presence: true
  validates :name, presence: true

  VALID_NUM_REGEX = /[0-9]+/

  validates :price, presence: true, format: { with: VALID_NUM_REGEX }

  default_scope order: 'products.created_at DESC'
end
