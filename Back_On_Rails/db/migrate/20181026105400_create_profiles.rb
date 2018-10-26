class CreateProfiles < ActiveRecord::Migration[5.2]
  def change
    create_table :profiles do |t|
      t.string :username
      t.string :first_name
      t.string :last_name
      t.integer :street_number
      t.string :street_name
      t.string :city
      t.string :province
      t.string :country
      t.date :date_of_birth
      t.string :phone_number

      t.timestamps
    end
  end
end
