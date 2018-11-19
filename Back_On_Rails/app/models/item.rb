class Item < ApplicationRecord
    ## TODO: find out how FK works and link to User table
    # WILL NEED TO USE ANOTHER MIGRATION TO ADD
    # ITEM ATTRIBUTES/COLUMNS
    belongs_to :user

    has_many :transactions, dependent: :destroy
    has_many :item_reviews, dependent: :destroy

    mount_uploaders :item_pictures, ItemPicturesUploader
    serialize :item_pictures, JSON

    validates :name, presence: true, length: { minimum: 3}
    validates :description, presence: true, length: { minimum: 10}
    validate :item_pictures_number

    def item_pictures_number
        if item_pictures.length > 5
            errors.add(:item_pictures, "You are only allowed to attach up to 5 pictures")
        end
    end

end
