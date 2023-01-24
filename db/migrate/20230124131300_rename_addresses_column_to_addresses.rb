class RenameAddressesColumnToAddresses < ActiveRecord::Migration[6.1]
  def change
    rename_column :addresses, :addresses, :address
  end
end
