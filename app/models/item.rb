class Item < ApplicationRecord
    ## TODO: find out how FK works and link to User table
    # WILL NEED TO USE ANOTHER MIGRATION TO ADD
    # ITEM ATTRIBUTES/COLUMNS
    belongs_to :user
    belongs_to :place, optional: true

    has_many :transactions, dependent: :destroy
    has_many :item_reviews, dependent: :destroy

    mount_uploaders :item_pictures, ItemPicturesUploader
    serialize :item_pictures, JSON
    has_many :item_tags
    has_many :tags, through: :item_tags
    validates :name, presence: true, length: { minimum: 3}
    validates :description, presence: true, length: { minimum: 10}
    validate :item_pictures_number
    validates :place_id, presence: true

    def item_pictures_number
        if item_pictures.length > 5
            errors.add(:item_pictures, "You are only allowed to attach up to 5 pictures")
        end
    end

    def get_ongoing_transactions
        item_transactions = self.transactions
        ongoing_transactions = Array.new
        item_transactions.each do |transaction|
            if(transaction.isApproved==1 && transaction.isReturned==0)
                ongoing_transactions << transaction
            end
        end
        return ongoing_transactions
    end

    def get_average_rating
        total_ratings = 0
        n = 0
        all_reviews = self.item_reviews
        all_reviews.each do |review|
            n = n + 1
            total_ratings = total_ratings + review.rating
        end
        if n==0
            n=1
        end
        return total_ratings.to_f/n
    end

    def get_rating_breakdown
        rating_hash = Hash.new { |hash, key| hash[key] = 0 }
        all_reviews = self.item_reviews
        all_reviews.each do |review|
            if review.rating == 1
                rating_hash[1] = rating_hash[1] + 1
            elsif review.rating == 2
                rating_hash[2] = rating_hash[2] + 1
            elsif review.rating == 3
                rating_hash[3] = rating_hash[3] + 1
            elsif review.rating == 4
                rating_hash[4] = rating_hash[4] + 1
            elsif review.rating == 5
                rating_hash[5] = rating_hash[5] + 1
            end
        end
        return rating_hash
    end

end
