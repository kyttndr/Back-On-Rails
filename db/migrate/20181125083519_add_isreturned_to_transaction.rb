class AddIsreturnedToTransaction < ActiveRecord::Migration[5.2]
  def change
    add_column :transactions, :isReturned, :integer
  end
end
