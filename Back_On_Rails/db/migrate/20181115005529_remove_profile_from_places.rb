class RemoveProfileFromPlaces < ActiveRecord::Migration[5.2]
  def change
    remove_reference :places, :profile, foreign_key: true
  end
end
