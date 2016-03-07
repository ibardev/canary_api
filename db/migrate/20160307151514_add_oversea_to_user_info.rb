class AddOverseaToUserInfo < ActiveRecord::Migration
  def change
    add_column :user_infos, :oversea, :boolean
  end
end
