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

class SmsToken < ActiveRecord::Base
  def self.register phone
    token = (0..9).to_a.sample(4).join

    if phone.present?
      company = "旅客"
      ChinaSMS.use :yunpian, password: "6eba427ea91dab9558f1c5e7077d0a3e"
      result = ChinaSMS.to phone, {company: company, code: token}, {tpl_id: 2}
    end

    sms_token = SmsToken.find_or_initialize_by phone: phone
    sms_token.token = token
    sms_token.save

    sms_token

  end
end
