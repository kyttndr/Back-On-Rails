class AddReferenceToBorrows < ActiveRecord::Migration[5.2]
  def change
      add_reference :borrows, :lender, index: true, foreign_key: {to_table: :users}
      add_reference :borrows, :borrower, index: true, foreign_key: {to_table: :users}
  end
end
