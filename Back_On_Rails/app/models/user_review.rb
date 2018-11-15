class UserReview < ApplicationRecord

    #edit_review used in a skip validation case
    attr_accessor :edit_review

    # ASSOCIATIONS
    belongs_to :user
    belongs_to :reviewee, class_name: 'User', foreign_key: 'reviewee_id'

    # VALIDATIONS
    validates :user, presence: true
    validates :reviewee, presence: true
    validates :rating, presence: true, numericality: {only_integer: true}, inclusion: {in: [1,2,3,4,5]}

    validate :user_has_lent_to_reviewee
    validate :user_cannot_have_multiple_reviews_of_same_reviewee, unless: :edit_review

    def user_has_lent_to_reviewee
        user = self.user
        reviewee = self.reviewee
        lend_transactions = user.lend_transactions

        lend_transactions.each do |transaction|
            if transaction.isApproved == 1 && transaction.isReturned == 1
                if transaction.borrower == reviewee
                    return 1
                end
            end
        end

        errors.add(:base, "You have never lent items to this user before!")
        return 0
    end

    def user_cannot_have_multiple_reviews_of_same_reviewee
        user = self.user
        reviewee = self.reviewee
        user_reviews = user.user_reviews

        user_reviews.each do |review|
            if review.reviewee == reviewee
                errors.add(:base, "You have already reviewed this user!")
                return 0
            end
        end
        return 1
    end

end
