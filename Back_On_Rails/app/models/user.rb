class User < ApplicationRecord
  has_many :items
  has_many :places
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

  #for facebook login
  devise :omniauthable, :omniauth_providers => [:facebook]

  validates :username, presence: true, uniqueness: true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, uniqueness: true, format: {with: VALID_EMAIL_REGEX}
  validates :password, presence: true, length: {minimum: 8}

  #after_commit :create_follow_notifications, on: [:add_friend]

  def self.search(param)
    param.strip!
    param.downcase!
    to_send_back = (username_matches(param) + email_matches(param)).uniq
    return nil unless to_send_back
    to_send_back
  end

  def self.username_matches(param)
    matches('username', param)
  end

  def self.email_matches(param)
    matches('email', param)
  end

  def self.matches(field_name, param)
    where("#{field_name} like ?", "%#{param}%")
  end

  def except_current_user(users)
    users.reject { |user| user.id == self.id }
  end

  def not_friends_with?(friend_id)
    friendships.where(friend_id: friend_id).count < 1
  end

  #def self.new_with_session(params, session)
    #super.tap do |user|
      #if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        #user.email = data["email"] if user.email.blank?
      #end
    #end
  #end
  
  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = "11111111"
      user.username = auth.info.name
      user.image = auth.info.image
    end
  end

	def create_follow_notifications
        Notification.create do |notification|
            notification.notify_type = 'friendship'
            notification.tag = 'follow'
            notification.actor = self.user
            notification.user = self.friend
            notification.target = self
            notification.second_target = self.item
        end
    end
end
