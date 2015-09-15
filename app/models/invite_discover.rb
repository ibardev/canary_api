# == Schema Information
#
# Table name: invite_discovers
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  begin_date :date
#  end_date   :date
#  content    :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_invite_discovers_on_user_id  (user_id)
#

class InviteDiscover < ActiveRecord::Base
  belongs_to :user
end
