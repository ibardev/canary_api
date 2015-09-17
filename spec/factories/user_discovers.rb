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

FactoryGirl.define do
  factory :user_discover do
    user nil
  end

end
