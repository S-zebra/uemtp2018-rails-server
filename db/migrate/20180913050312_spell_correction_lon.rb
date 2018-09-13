class SpellCorrectionLon < ActiveRecord::Migration[5.2]
  def change
    remove_column :posts, :longtitude
    add_column :posts, :longitude, :float, null: false, default: -1
    #Ex:- add_column("admin_users", "username", :string, :limit =>25, :after => "email")
  end
end
