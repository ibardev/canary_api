# == Schema Information
#
# Table name: user_counts
#
#  id             :integer          not null, primary key
#  like_index     :integer
#  follow_index   :integer
#  respond_index  :integer
#  user_id        :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  message_index  :integer
#  discover_index :integer
#
# Indexes
#
#  index_user_counts_on_user_id  (user_id)
#

class UserCount < ActiveRecord::Base
  belongs_to :user

  def new_like?
    user.likes.first.try(:id).to_i > like_index.to_i
  end

  def new_follow?
    user.followings.first.try(:id).to_i > follow_index.to_i
  end

  def new_respond?
    user.invite_responds.first.try(:id).to_i > respond_index.to_i
  end

  def new_message?
    Message.all.first.try(:id).to_i > message_index.to_i
  end

  def new_discover?
    Discover.unblock.available.first.try(:id).to_i > discover_index.to_i
  end
end
