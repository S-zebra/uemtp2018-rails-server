class SpellCorrection < ActiveRecord::Migration[5.2]
  def change
    remove_column :posts, :longtitude
    change_column :posts, :longitude, :float, null: false, default: -1
    #Ex:- change_column("admin_users", "email", :string, :limit =>25)
  end
end
