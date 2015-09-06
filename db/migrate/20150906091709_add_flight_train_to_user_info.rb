class AddFlightTrainToUserInfo < ActiveRecord::Migration
  def change
    add_column :user_infos, :flight, :string
    add_column :user_infos, :train, :string
  end
end
