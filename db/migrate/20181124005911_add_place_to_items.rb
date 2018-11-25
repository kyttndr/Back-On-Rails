class AddPlaceToItems < ActiveRecord::Migration[5.2]
  def change
    add_reference :items, :place, foreign_key: true
  end
end
