class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :post_tags, dependent: :destroy
  has_many :tags, through: :post_tags

  enum status: { draft: 0, published: 1 }

  validates :title, presence: true
  validates :content, presence: true
end
