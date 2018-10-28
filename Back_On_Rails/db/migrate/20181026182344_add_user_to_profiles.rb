class AddUserToProfiles < ActiveRecord::Migration[5.2]
  def change
    add_reference :profiles, :user, index: { unique: true }
    add_foreign_key :profiles, :users, column: :user_id, dependent: :destroy, :unique => true
  end
end
