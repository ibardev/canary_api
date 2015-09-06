class AddHotelTypeToUserinfo < ActiveRecord::Migration
  def change
    add_column :user_infos, :hotel_type, :integer
  end
end
