class AddItemPicturesToItems < ActiveRecord::Migration[5.2]
  def change
    add_column :items, :item_pictures, :string
  end
end
