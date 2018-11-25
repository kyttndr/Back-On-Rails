class CreateUserReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :user_reviews do |t|

        t.references :user, index: true, foreign_key: true
        t.references :reviewee, index: true, foreign_key: {to_table: :users}

        t.integer :rating
        t.text :comment

        t.timestamps
    end
  end
end
