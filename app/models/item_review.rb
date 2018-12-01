class ItemReview < ApplicationRecord

    #edit_review used in a skip validation case
    attr_accessor :edit_review

    # ASSOCIATIONS
    belongs_to :user
    belongs_to :item

    # VALIDATIONS
    validates :user, presence: true
    validates :item, presence: true
    validates :rating, presence: true, numericality: {only_integer: true}, inclusion: {in: [1,2,3,4,5]}

    validate :user_has_borrowed_item
    validate :user_cannot_have_multiple_reviews_of_same_item, unless: :edit_review

    def user_has_borrowed_item
        review_user = self.user
        review_item = self.item
        transactions = review_user.borrow_transactions

        transactions.each do |transaction|
            if transaction.isApproved == 1
                borrowed_item = transaction.item
                if borrowed_item == review_item
                    return 1
                end
            end
        end

        errors.add(:base, "This item has never been borrowed by you before!")
        return 0
    end

    def user_cannot_have_multiple_reviews_of_same_item
        review_user = self.user
        review_item = self.item
        all_reviews_by_user = review_user.item_reviews

        all_reviews_by_user.each do |review|
            if review.item == review_item
                errors.add(:base, "You have already reviewed this item!")
                return 0
            end
        end
        return 1

    end

end
