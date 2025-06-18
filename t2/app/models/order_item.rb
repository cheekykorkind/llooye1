class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :book

  validates :quantity, presence: true, numericality: { greater_than: 1 }
  validates :unit_price, presence: true, numericality: { greater_than: 0 }
end
