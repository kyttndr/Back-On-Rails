class UserReview < ApplicationRecord

    # ASSOCIATIONS
    belongs_to :user
    belongs_to :reviewee, class_name: 'User', foreign_key: 'reviewee_id'

    # VALIDATIONS
    validates :user, presence: true
    validates :reviewee, presence: true
    validates :rating, presence: true, numericality: {only_integer: true}, inclusion: {in: [1,2,3,4,5]}

end
