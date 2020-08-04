class RenameAddresCityColumnToUsers < ActiveRecord::Migration[5.2]
  def change
    rename_column :users, :addres_city, :address_city
  end
end
