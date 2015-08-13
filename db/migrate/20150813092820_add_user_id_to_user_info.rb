class AddUserIdToUserInfo < ActiveRecord::Migration
  def change
    add_reference :user_infos, :user, index: true, foreign_key: true
  end
end
