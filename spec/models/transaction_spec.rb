require 'rails_helper'

RSpec.describe Transaction, type: :model do

    context 'validation tests' do
        it 'ensures lender presence' do

        end
        it 'ensures borrower presence' do

        end
        it 'ensures item presence' do

        end
    end

    context 'search tests' do
        it 'ensures item can be searched for' do
            fake_transaction = [instance_double("Transaction")]
            expect(Transaction).to receive(:find)
                .with(1).and_return(fake_transaction)
            expect(Transaction.find(1)).to eq(fake_transaction)
        end
    end

end
