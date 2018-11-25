class Friendship < ApplicationRecord
	belongs_to :user
	belongs_to :friend, :class_name => 'User'
	#after_commit :create_follow_notifications, on: [:add_friend]

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
