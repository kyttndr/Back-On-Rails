class RemoveAddressFromProfile < ActiveRecord::Migration[5.2]
  def change
    remove_column :profiles, :street_number, :integer
    remove_column :profiles, :street_name, :string
    remove_column :profiles, :city, :string
    remove_column :profiles, :province, :string
    remove_column :profiles, :country, :string
  end
end
