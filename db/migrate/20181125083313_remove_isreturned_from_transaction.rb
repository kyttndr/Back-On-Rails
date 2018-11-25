class RemoveIsreturnedFromTransaction < ActiveRecord::Migration[5.2]
  def change
    remove_column :transactions, :isReturned
  end
end
