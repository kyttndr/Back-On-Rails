class CreateReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :reviews do |t|

        t.references :item, index: true, foreign_key: true
        t.references :reviewer, index: true, foreign_key: {to_table: :users}
        t.references :reviewee, index: true, foreign_key: {to_table: :users}
        t.integer :review_type
        
        t.integer :rating
        t.text :comment
        t.date :review_date

        t.timestamps
    end
  end
end
