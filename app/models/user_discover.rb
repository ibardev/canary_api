# == Schema Information
#
# Table name: user_discovers
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_user_discovers_on_user_id  (user_id)
#

class UserDiscover < ActiveRecord::Base
  belongs_to :user
  has_one :discover, as: :discoverable, dependent: :destroy
  before_create :remove_duplicate_discover
  after_create :add_discover

  def as_json options=nil
    {
      
    }
  end

  private
    # 统一用户只保留最新的一条记录（根据user_id）
    # 因此需要删除原来的UserDiscover和Discover记录
    def remove_duplicate_discover
      discover = UserDiscover.find_by user_id: user_id
      discover.destroy if discover.present?
    end

    def add_discover
      self.create_discover user: user
    end
end
