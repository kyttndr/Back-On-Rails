class CreateItemTags < ActiveRecord::Migration[5.2]
  def change
    create_table :item_tags do |t|
      t.integer :item_id
      t.integer :tag_id
    end
  end
end
