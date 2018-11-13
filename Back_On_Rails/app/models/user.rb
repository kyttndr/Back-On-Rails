class User < ApplicationRecord
  has_many :items
  
  has_many :friendships
  has_many :friends, through: :friendships
  
  has_one :profile, dependent: :destroy

  #user has_many borrows through the lender fk in borrow model
  has_many :borrow_transactions, class_name: 'Transaction', foreign_key: 'borrower_id', inverse_of: 'borrower', dependent: :destroy
  #user has_many borrows through the lender fk in borrow model
  has_many :lend_transactions, class_name: 'Transaction', foreign_key: 'lender_id', inverse_of: 'lender', dependent: :destroy

  # Reviews that the user wrote
  has_many :item_reviews, dependent: :destroy
  has_many :user_reviews, dependent: :destroy

  # Reviews that were written about the user
  has_many :reviews_of_self, class_name: 'UserReview', foreign_key: 'reviewee_id', inverse_of: 'reviewee', dependent: :destroy

  has_secure_password

  validates :username, presence: true, uniqueness: true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, uniqueness: true, format: {with: VALID_EMAIL_REGEX}
  validates :password, presence: true, length: {minimum: 8}
end
