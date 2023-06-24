class AccountCorrection < ActiveRecord::Migration[5.2]
  def change
    change_column :accounts, :name, :string, unique: true
    change_column :accounts, :birthday, :date
    #Ex:- change_column("admin_users", "email", :string, :limit =>25)
    #Ex:- change_column("admin_users", "email", :string, :limit =>25)
  end
end
