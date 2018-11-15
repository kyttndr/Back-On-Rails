class RemoveProfileFromPlaces < ActiveRecord::Migration[5.2]
  def change
    remove_column :places, :profile, :ferences
  end
end
