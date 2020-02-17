class AddFriendsPair < ActiveRecord::Migration[5.2]
  def change
    add_column :requests, :friend_pair, :string
    #Ex:- add_column("admin_users", "username", :string, :limit =>25, :after => "email")
  end
end
