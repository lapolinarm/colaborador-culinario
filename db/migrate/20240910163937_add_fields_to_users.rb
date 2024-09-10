class AddFieldsToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :dni, :integer
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :mobile_phone, :string
    add_column :users, :role, :integer
    add_column :users, :address, :string
    add_column :users, :payment_method, :integer
    add_column :users, :bank, :string
    add_column :users, :name_holder, :string
    add_column :users, :bank_account, :string
    add_column :users, :cci, :string
    add_column :users, :digital_wallet, :string
  end
end
