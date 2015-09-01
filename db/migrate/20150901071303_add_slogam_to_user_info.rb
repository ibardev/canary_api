class AddSlogamToUserInfo < ActiveRecord::Migration
  def change
    add_column :user_infos, :slogan, :string
  end
end
