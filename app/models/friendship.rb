class DuplicateValidator < ActiveModel::Validator
  def validate(friendship)
    if friendship.user_id == friendship.friend_id
      friendship.errors[:base] << "This friendship is invalid #{friendship.user_id}, #{friendship.friend_id} "
    end
  end
end

class Friendship < ApplicationRecord
	belongs_to :user
	belongs_to :friend, :class_name => 'User'
  
  validates_with DuplicateValidator
  
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
