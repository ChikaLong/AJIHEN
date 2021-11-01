class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy

  attachment :profile_image

  validates :name, presence: true, uniqueness: true, length: { minimum: 1, maximum: 10 }
  validates :profile, length: { maximum: 50 }
end
