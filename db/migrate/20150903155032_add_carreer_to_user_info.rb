class AddCarreerToUserInfo < ActiveRecord::Migration
  def change
    add_column :user_infos, :carreer, :integer
  end
end
