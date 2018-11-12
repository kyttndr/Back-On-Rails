class Transaction < ApplicationRecord

    belongs_to :item

    #borrower is a fk to user_id
    belongs_to :borrower, class_name: 'User', foreign_key: 'borrower_id'

    #lender is a fk to user_id
    belongs_to :lender, class_name: 'User', foreign_key: 'lender_id'

    validates :lender, presence: true
    validates :borrower, presence: true
    validates :item, presence: true

    validates :start_date, presence: true
    validates :end_date, presence: true
    validates :isReturned, presence: true, numericality: {only_integer: true}, inclusion: {in: [0,1]}

    #0 - pending     #1 - approved      #2 - rejected
    validates :isApproved, presence: true, numericality: {only_integer: true}, inclusion: {in: [0,1,2]}

    validate :validate_transaction_period

    def validate_transaction_period

        # CHECK BASIC PERIOD ENDPOINTS
        if(self.start_date.nil? || self.end_date.nil?)
            return 0
        end
        if(self.start_date < Date.current)
            # Invalid Period
            errors.add(:start_date, "cannot be in the past")
            return 0
        end
        if(self.start_date > self.end_date)
            # Invalid Period
            errors.add(:start_date, "cannot be after end date")
            return 0
        end

        # CHECK FOR TRANSACTION PERIOD OVERLAPS
        transaction_item = self.item
        all_transactions_for_item = transaction_item.transactions
        all_transactions_for_item.each do |transaction|
            if(transaction.isApproved == 1)
                # Check [..(..]...) type period overlap
                if(self.start_date >= transaction.start_date &&
                    self.start_date <= transaction.end_date)
                    errors.add(:start_date, "is unavailable")
                    return 0
                end

                # Check (...[.)..] type period overlap
                if(self.end_date <= transaction.end_date &&
                    self.end_date >= transaction.start_date)
                    errors.add(:end_date, "is unavailable")
                    return 0
                end

                # Check (...[...]...) type period overlap
                if(self.start_date < transaction.start_date &&
                    self.end_date > transaction.end_date)
                    errors.add(:period, "is unavailable")
                    return 0
                end
            end
        end
        return 1
    end

end
