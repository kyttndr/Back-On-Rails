class RemoveTitleFromPlaces < ActiveRecord::Migration[5.2]
  def change
    remove_column :places, :title, :string
  end
end
