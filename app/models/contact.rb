class Contact < ApplicationRecord
  validates :name, presence: true, length: { minimum: 1, maximum: 20 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i.freeze
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }
  validates :subject, presence: true, length: { maximum: 50 }
  validates :message, presence: true, length: { maximum: 500 }
end
