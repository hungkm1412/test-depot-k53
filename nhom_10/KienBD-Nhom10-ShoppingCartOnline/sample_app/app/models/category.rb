class Category < ActiveRecord::Base
  attr_accessible :name
  has_many :products, dependent: :destroy
  validates :name,presence: true,uniqueness: { case_sensitive: false }
  
end
