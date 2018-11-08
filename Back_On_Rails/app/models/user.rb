class User < ApplicationRecord
  has_many :items
  has_one :profile, dependent: :destroy

  #has_many :borrows
  #has_many :items, :through => :borrows

  #user has_many borrows through the lender fk in borrow model
  has_many :borrows, foreign_key: :lender

  #user has_many borrows through the lender fk in borrow model
  has_many :borrows, foreign_key: :borrower

  has_secure_password

  validates :username, presence: true, uniqueness: true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, uniqueness: true, format: {with: VALID_EMAIL_REGEX}
  validates :password, presence: true, length: {minimum: 8}
end
