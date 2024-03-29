class Category < ActiveRecord::Base
  attr_accessible :name
  validates :name, presence: true
  has_many :products , dependent: :destroy

  default_scope order: 'categories.created_at DESC'
end
