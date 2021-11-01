class Post < ApplicationRecord
  belongs_to :user
  belongs_to :category
  has_many :post_tags, dependent: :destroy
  has_many :tags, through: :post_tags
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  attachment :image

  validates :image, presence: true
  validates :item_name, presence: true, length: { maximum: 50 }
  validates :review, presence: true, length: { maximum: 500 }
  validates :country, presence: true
  validates :place, presence: true
  validates :price, presence: true
  validates :rate, presence: true

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end
end
