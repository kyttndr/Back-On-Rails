class Transaction < ApplicationRecord

    #belongs_to :user
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

    #0 - pending
    #1 - approved
    #2 - rejected
    validates :isApproved, presence: true, numericality: {only_integer: true}, inclusion: {in: [0,1,2]}

end
