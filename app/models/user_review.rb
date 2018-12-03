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

    validate :user_has_past_transaction_with_reviewee
    validate :user_cannot_have_multiple_reviews_of_same_reviewee, unless: :edit_review

    def user_has_past_transaction_with_reviewee
        user = self.user
        reviewee = self.reviewee

        transactions = Transaction.where(borrower: user, lender: reviewee, isApproved: 1)
                                  .where("start_date <= ?", Date.current)
        if transactions.any?
            return true
        end

        transactions = Transaction.where(borrower: reviewee, lender: user, isApproved: 1)
                                  .where("start_date <= ?", Date.current)
        if transactions.any?
            return true
        end

        errors.add(:base, "You have never borrowed or lent anything from this user before!")
        return nil
    end

    def user_cannot_have_multiple_reviews_of_same_reviewee
        user = self.user
        reviewee = self.reviewee
        user_reviews = user.user_reviews

        user_reviews.each do |review|
            if review.reviewee == reviewee
                errors.add(:base, "You have already reviewed this user!")
                return true
            end
        end
        return nil
    end

end
