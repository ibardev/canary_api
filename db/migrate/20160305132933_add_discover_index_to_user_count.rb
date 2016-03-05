class AddDiscoverIndexToUserCount < ActiveRecord::Migration
  def change
    add_column :user_counts, :discover_index, :integer
  end
end
