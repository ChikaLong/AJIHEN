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

  # 検索フォームにて商品名、レビュー内容、原産国、購入場所などで部分一致検索をかけられるようにする
  def self.search(search)
    if search != ""
      Post.where(['item_name LIKE ? OR review LIKE ? OR country LIKE ? OR place LIKE ?', "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%"])
    else
      Post.all
    end
  end
end
