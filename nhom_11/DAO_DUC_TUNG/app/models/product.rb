class Product < ActiveRecord::Base
  attr_accessible :description, :name, :price, :category_id

  validates :name, presence: true, uniqueness: true
  validates :price, presence: true, format: { with: /\d+/ }
  validates :description, presence: true

  belongs_to :category
end
