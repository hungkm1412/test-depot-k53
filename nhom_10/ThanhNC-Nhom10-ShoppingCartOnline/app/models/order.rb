class Order < ActiveRecord::Base
  attr_accessible :address, :note, :phone_number, :product_id, :status, :user_id
  belongs_to :user

  validates :product_id, presence: true
  validates :user_id, presence: true
  validates :status, presence: true

end
