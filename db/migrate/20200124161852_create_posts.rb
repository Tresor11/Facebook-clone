class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.string :content
      t.integer :creator_id
      t.timestamps
    end
    add_foreign_key :posts, :users, column: :creator_id 
  end
end
