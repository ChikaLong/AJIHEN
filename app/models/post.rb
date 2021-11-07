class Post < ApplicationRecord
  belongs_to :user
  belongs_to :category
  has_many :post_tags, dependent: :destroy
  has_many :tags, through: :post_tags
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :notifications, dependent: :destroy

  attachment :image

  validates :image, presence: true
  validates :item_name, presence: true, length: { maximum: 50 }
  validates :review, presence: true, length: { maximum: 500 }
  validates :country, presence: true
  validates :place, presence: true
  validates :price, presence: true
  validates :rate, presence: true

  # ソート機能用
  scope :latest, -> { order(created_at: :desc) }
  scope :rating, -> { order(rate: :desc) }
  # scope :many, -> { find(Comment.group(:post_id).order('count(post_id) desc').pluck(:post_id)) }
  # scope :like, -> { find(Favorite.group(:post_id).order('count(post_id) desc').pluck(:post_id)) }
  scope :many, -> { Post.joins("left join comments on posts.id=comments.post_id").group("posts.id").order("count(comments.id) desc") }
  scope :like, -> { Post.joins("left join favorites on posts.id=favorites.post_id").group("posts.id").order("count(favorites.id) desc") }

  # ランキング表示用
  scope :week, -> { find(Favorite.group(:post_id).where(created_at: Time.current.all_week).order('count(post_id) desc').limit(3).pluck(:post_id)) }
  scope :month, -> { find(Favorite.group(:post_id).where(created_at: Time.current.all_month).order('count(post_id) desc').limit(3).pluck(:post_id)) }


  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

  def create_notification_by(current_user)
    notification = current_user.active_notifications.new(
      post_id: id,
      visited_id: user_id
    )
    if notification.visiter_id == notification.visited_id
      notification.checked = true
    end
    notification.save if notification.valid?
  end
end
