class Order < ActiveRecord::Base
  attr_accessible :cart_id, :user_id
  belongs_to :cart
  belongs_to :user
  has_many :items, through: :cart, source: :items

  validates :user_id, presence: true
  validates :cart_id, presence: true
end
