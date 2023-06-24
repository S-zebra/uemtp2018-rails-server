class CreateLocations < ActiveRecord::Migration[5.2]
  def change
    create_table :locations do |t|
      t.references :account, null: false
      t.float :latitude, null: false, default: -1.0
      t.float :longitude, null: false, default: -1.0
      t.timestamps
    end
  end
end
