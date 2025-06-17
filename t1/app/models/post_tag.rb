class PostTag < ApplicationRecord
  belongs_to :post
  belongs_to :tag

  validates :tag_id, presence: true, uniqueness: { case_sensitive: true }
end
