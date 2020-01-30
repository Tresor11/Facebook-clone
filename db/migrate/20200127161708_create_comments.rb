class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.string :comment_content
      t.integer :commenter_id
      t.references :post
      t.timestamps
    end
    add_foreign_key :comments, :users, column: :commenter_id 
  end
end
