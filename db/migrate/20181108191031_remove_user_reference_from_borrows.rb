class RemoveUserReferenceFromBorrows < ActiveRecord::Migration[5.2]
  def change
      remove_reference :borrows, :user, index: true, foreign_key: true
  end
end
