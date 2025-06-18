class Order < ApplicationRecord
  has_many :order_items, dependent: :destroy
  has_many :books, through: :order_items

  validates :name, presence: true, uniqueness: { case_sensitive: true }

  attribute :order_date, :datetime, default: -> { Time.current }
  validates :order_date, presence: true
  validates :total_price, presence: true, numericality: { greater_than: 0 }
  enum status: { pending: 0, shipped: 1, delivered: 2, cancelled: 3 }

end
