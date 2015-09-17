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

require 'rails_helper'

RSpec.describe UserDiscover, type: :model do
  it { should belong_to(:user) } 

  it "should add discover also" do
    @user = create(:user)
    @user_discover = create(:user_discover, user: @user)
    expect(@user_discover.user).to eq(@user)
    expect(@user_discover.discover).not_to be_nil
  end

  it "should remove duplicate record" do
    @user_1 = create(:user, phone: "12345678912")
    @user_2 = create(:user)
    create(:user_discover, user: @user_1)
    create(:user_discover, user: @user_2)
    expect(Discover.count).to eq(2)
    expect(UserDiscover.count).to eq(2)

    create(:user_discover, user: @user_1)
    expect(Discover.count).to eq(2)
    expect(UserDiscover.count).to eq(2)
  end
end
