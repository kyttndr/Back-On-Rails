class Item < ApplicationRecord
    ## TODO: find out how FK works and link to User table
    # WILL NEED TO USE ANOTHER MIGRATION TO ADD
    # ITEM ATTRIBUTES/COLUMNS
    belongs_to :user

    has_many :transactions, dependent: :destroy
    has_many :item_reviews, dependent: :destroy

    validates :name, presence: true, length: { minimum: 3}
    validates :description, presence: true, length: { minimum: 10}

end
