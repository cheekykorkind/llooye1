class Book < ApplicationRecord
  has_many :orders, through: :post_tags
  has_many :order_items, dependent: :destroy

  belongs_to :author

  validates :title, presence: true
  validates :author, presence: true
  validates :published_year, presence: true
  validates :isbn, presence: true
  validates :price, presence: true, numericality: { greater_than: 0 }
  validates :stock_quantity, presence: true, numericality: { greater_than: 0 }
end
