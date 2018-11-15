class RemoveVisitedByFromPlaces < ActiveRecord::Migration[5.2]
  def change
    remove_column :places, :visited_by, :string
  end
end
