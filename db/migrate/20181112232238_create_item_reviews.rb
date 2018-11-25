class CreateItemReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :item_reviews do |t|

        t.references :user, index: true, foreign_key: true
        t.references :item, index: true, foreign_key: true
        t.integer :rating
        t.text :comment

        t.timestamps
    end
  end
end
