class AddDiscoverAtToUserCount < ActiveRecord::Migration
  def change
    add_column :user_counts, :discover_at, :datetime
  end
end
