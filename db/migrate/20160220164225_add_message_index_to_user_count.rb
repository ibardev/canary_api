class AddMessageIndexToUserCount < ActiveRecord::Migration
  def change
    add_column :user_counts, :message_index, :integer
  end
end
