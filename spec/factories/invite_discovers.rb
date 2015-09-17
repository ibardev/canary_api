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

FactoryGirl.define do
  factory :invite_discover do
    begin_date "2015-09-15"
    end_date "2015-09-15"
    content "MyText"

    after(:build) do |invite|
      invite.images = create_list(:image, 3)
    end
  end

end
