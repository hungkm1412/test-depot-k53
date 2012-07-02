class Product < ActiveRecord::Base
  attr_accessible :category, :detail, :name, :pro_id, :price
  # belongs_to :category   

  validates :pro_id, presence: true
  validates :name, presence: true
  validates :price, presence: true
  validates_numericality_of :price, :greater_than => 0

end
