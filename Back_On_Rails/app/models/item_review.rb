class ItemReview < ApplicationRecord

    # ASSOCIATIONS
    belongs_to :user
    belongs_to :item

    # VALIDATIONS
    validates :user, presence: true
    validates :item, presence: true
    validates :rating, presence: true, numericality: {only_integer: true}, inclusion: {in: [1,2,3,4,5]}

    # CANNOT CREATE MORE THAN ONE REVIEW

    # CANNOT REVIEW SOMETHING YOU DID NOT BORROW

end
