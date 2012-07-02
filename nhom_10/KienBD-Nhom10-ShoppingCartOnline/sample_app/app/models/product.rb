class Product < ActiveRecord::Base
  attr_accessible :name, :price,:category_id
  belongs_to :category
  belongs_to :item
  validates :category_id,presence: true
  validates :name,presence: true
  validates_numericality_of :price,greater_than: 0

  default_scope order: 'products.created_at DESC'
end
