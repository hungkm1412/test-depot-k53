class Product < ActiveRecord::Base
  attr_accessible :description, :name, :price, :category_id

  validates :name, presence: true, length: { minimum: 6 }, uniqueness: true
  validates :price, presence: true
  validates_numericality_of :price, :greater_than => 0
  belongs_to :category
  has_many :cart_item
end
