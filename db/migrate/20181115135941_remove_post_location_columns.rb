class RemovePostLocationColumns < ActiveRecord::Migration[5.2]
  # ローカル環境用です…
  def up
    # remove_column :posts, :latitude
    # remove_column :posts, :longitude
  end

  def down
    # add_column :posts, :latitude, :float, {:default => -999, :null => false}
    # add_column :posts, :longitude, :float, {:default => -999, :null => false}
  end
end
