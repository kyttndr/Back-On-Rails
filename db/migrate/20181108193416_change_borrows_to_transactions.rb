class ChangeBorrowsToTransactions < ActiveRecord::Migration[5.2]
  def change
      remove_index :borrows, :item_id
      remove_index :borrows, :borrower_id
      remove_index :borrows, :lender_id

      rename_table :borrows, :transactions

      add_index :transactions, :item_id
      add_index :transactions, :borrower_id
      add_index :transactions, :lender_id

  end
end
