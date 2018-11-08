class Item < ApplicationRecord
    ## TODO: find out how FK works and link to User table
    # WILL NEED TO USE ANOTHER MIGRATION TO ADD
    # ITEM ATTRIBUTES/COLUMNS
    belongs_to :user

    has_many :transactions
    #has_many :users, :through => :borrows

    validates :name, presence: true, length: { minimum: 3}
    validates :description, presence: true, length: { minimum: 10}

    #Check if Item instance is currently being borrowed
    def isBorrowed?
        borrow_records = self.transactions
        borrow_records.each do |record|
            if(record.isReturned==0)
                return 1    #Item is currently borrowed
            end
        end
        return 0    #Item is not currently borrowed
    end

end
