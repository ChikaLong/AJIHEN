class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :post

  # １人１投稿１お気に入り
  validates_uniqueness_of :post_id, scope: :user_id
end
