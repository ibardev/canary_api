class AddBanToUser < ActiveRecord::Migration
  def change
    add_column :users, :ban, :boolean
  end
end
