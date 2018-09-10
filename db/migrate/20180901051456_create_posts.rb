class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.references :account, null: false
      t.float :latitude, null: false, default: -1
      t.float :longtitude, null: false, default: -1
      t.text :text, null: false
      t.timestamps
    end
  end
end
