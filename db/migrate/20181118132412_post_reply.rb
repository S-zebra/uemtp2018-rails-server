class PostReply < ActiveRecord::Migration[5.2]
  def change
    add_reference :posts, :post
  end
end
