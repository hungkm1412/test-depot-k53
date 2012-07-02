class Product < ActiveRecord::Base
  attr_accessible :name, :price, :category_id
  belongs_to :category
  has_many :carts
  before_save { |product| product.name = name.downcase }
  validates :name, presence: true, length: { maximum: 50 }, uniqueness: true
  validates :price, presence:true
  validates :category_id, presence: true
end
