# == Schema Information
#
# Table name: sms_tokens
#
#  id         :integer          not null, primary key
#  phone      :string
#  token      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_sms_tokens_on_phone  (phone)
#

require 'rails_helper'

RSpec.describe SmsToken, type: :model do
  it 'should return error if user is ban' do
    user = create(:user)
    user.ban!

    sms_token = SmsToken.register user.phone
    expect(sms_token.errors).not_to eq(nil)
  end
end
