class AddDateMoreInfoToAccounts < ActiveRecord::Migration[7.0]
  def change
    add_column :accounts, :date_of_birth, :date
    add_column :accounts, :gender, :string
    add_column :accounts, :username, :string
    add_column :accounts, :name_title, :string
    add_column :accounts, :first_name, :string
    add_column :accounts, :last_name, :string
    add_column :accounts, :phone_number, :string
    add_column :accounts, :address, :text
    add_column :accounts, :bank_name, :string
    add_column :accounts, :account_name, :string
    add_column :accounts, :account_no, :string
    add_column :accounts, :staff_no, :string
  end
end
