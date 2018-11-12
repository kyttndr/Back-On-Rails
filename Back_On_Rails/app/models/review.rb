class Review < ApplicationRecord

    # ASSOCIATIONS
    belongs_to :item
    #reviewer is a fk to user_id
    belongs_to :reviewer, class_name: 'User', foreign_key: 'reviewer_id'
    #reviewee is a fk to user_id
    belongs_to :reviewee, class_name: 'User', foreign_key: 'reviewee_id'

    enum review_type: {item_review: 0, user_review: 1}

    # VALIDATIONS
    validates :reviewer, presence: true
    validates :review_type, presence: true, numericality: {only_integer: true}, inclusion: {in: [0,1]}
    validates :rating, presence: true, numericality: {only_integer: true}, inclusion: {in: [1,2,3,4,5]}
    validates :review_date, presence: true

end
