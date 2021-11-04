class PostTag < ApplicationRecord
  belongs_to :post
  belongs_to :tag
  
  validates :tag_id, presence: true
  validates :post_id, presence: true
end
