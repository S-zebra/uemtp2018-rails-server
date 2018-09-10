class CreateAccounts < ActiveRecord::Migration[5.2]
  def change
    create_table :accounts do |t|
      t.string :name, null: false
      t.string :password
      t.string :image_path
      t.string :sex, null: false # m of f
      t.date :birthday, null: false
      t.timestamps
    end
  end
end
