class User < ApplicationRecord
  has_many :items
  has_one :profile, dependent: :destroy

  has_many :borrows
  #has_many :items, :through => :borrows

  has_secure_password

  validates :username, presence: true, uniqueness: true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, uniqueness: true, format: {with: VALID_EMAIL_REGEX}
  validates :password, presence: true, length: {minimum: 8}
end
