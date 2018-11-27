class CreateBorrows < ActiveRecord::Migration[5.2]
  def change
    create_table :borrows do |t|

        t.references :user, foreign_key: true, index: true
        t.references :item, foreign_key: true, index: true
        t.date :start_date
        t.date :end_date
        t.integer :isReturned

    end
  end
end
