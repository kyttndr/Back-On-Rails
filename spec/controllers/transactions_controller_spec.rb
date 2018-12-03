require 'rails_helper'

RSpec.describe TransactionsController, type: :controller do

    let(:valid_attributes) {
      skip("Add a hash of attributes valid for your model")
    }

    curr_user = FactoryBot.create(:user)

    describe 'GET #borrow_index' do
        it "returns http success" do
            #curr_user = FactoryBot.create(:user)
            get :borrow_index, params: {}, session: {user_id: curr_user.id}
            expect(response).to have_http_status(:success)
        end

        it "assigns current_borrow_transactions" do
            #curr_user = FactoryBot.create(:user)
            get :borrow_index, params: {}, session: {user_id: curr_user.id}
            expect(assigns(:current_borrow_transactions)).to be_an_instance_of(Array)
        end
    end

    describe 'GET #new' do
        it "returns http success" do
            #item = FactoryBot.create(:item)
            #get :new, params: {item_id: item.id}, session: {user_id: curr_user.id}
            #expect(response).to have_http_status(:success)
        end

        it 'calls item model that performs DB search' do
            #fake_item = instance_double("Item")

            #expect(Item).to receive(:find).with("1")
            #get :new, params: {item_id: 1, transaction: valid_attributes}, session: session_hash
        end
    end

    describe 'POST #create' do
        it "returns http success" do
            #get :create, params: {transaction: valid_attributes}, session: session_hash
            #expect(response).to have_http_status(:success)
        end

        it 'creates a new transaction instance in the db' do
            expect {
                post :create, params: {transaction: valid_attributes}, session: session_hash
            }.to change(Transaction, :count).by(1)
        end
    end


end
