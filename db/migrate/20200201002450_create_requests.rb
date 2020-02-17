class CreateRequests < ActiveRecord::Migration[5.2]
  def change
    create_table :requests do |t|
      t.integer :sender_id
      t.integer :recever_id
      t.boolean :status
      t.timestamps
    end
    add_index :requests, :sender_id
    add_index :requests, :recever_id
    add_foreign_key :requests, :users, column: :sender_id 
    add_foreign_key :requests, :users, column: :recever_id
  end
end
