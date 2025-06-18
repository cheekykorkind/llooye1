class Book < ApplicationRecord
  has_many :order_items, dependent: :destroy
  has_many :orders, through: :order_items

  belongs_to :author

  validates :title, presence: true
  validates :author, presence: true
  validates :published_year, presence: true
  validates :isbn, presence: true, uniqueness: { case_sensitive: true }
  validates :price, presence: true, numericality: { greater_than: 0 }
  validates :stock_quantity, presence: true, numericality: { greater_than: 0 }
end
