class BookTag < ApplicationRecord
  belongs_to :book
  belongs_to :tag
  validates :post_id, presence: true
  validates :tag_id, presence: true
end
