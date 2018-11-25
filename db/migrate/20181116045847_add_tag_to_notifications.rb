class AddTagToNotifications < ActiveRecord::Migration[5.2]
  def change
      add_column :notifications, :tag, :string
  end
end
