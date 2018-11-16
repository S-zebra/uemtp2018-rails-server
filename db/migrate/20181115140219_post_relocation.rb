class PostRelocation < ActiveRecord::Migration[5.2]
  def change
    add_reference :locations, :post, {:index => true}
  end
end
