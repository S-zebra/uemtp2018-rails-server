class CreatePostImages < ActiveRecord::Migration[5.2]
  def change
    create_table :post_images do |t|
      t.references :post, null: false, index: true, foreign_key: true
      t.references :image, null: false, index: true, foreign_key: true
      t.timestamps
    end
  end
end
