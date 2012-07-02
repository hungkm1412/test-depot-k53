class Category < ActiveRecord::Base
  attr_accessible :description, :name

  validates :name, presence: true, uniqueness: true, length: { minimum: 6 }
  has_many :products
end
