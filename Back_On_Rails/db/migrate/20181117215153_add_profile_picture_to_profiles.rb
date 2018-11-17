class AddProfilePictureToProfiles < ActiveRecord::Migration[5.2]
  def change
    add_column :profiles, :profile_picture, :string
  end
end
