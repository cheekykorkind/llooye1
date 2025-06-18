class Order < ApplicationRecord
  has_many :books, through: :post_tags
  has_many :order_items, dependent: :destroy

  # enum status: { draft: 0, published: 1 }

  validates :name, presence: true, uniqueness: { case_sensitive: true }

  attribute :order_date, :datetime, default: -> { Time.current }
  validates :order_date, presence: true
  validates :total_price, presence: true, numericality: { greater_than: 0 }
  enum status: { pending: 0, shipped: 1, delivered: 2, cancelled: 3 }

end
