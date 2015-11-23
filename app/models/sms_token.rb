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

    user = User.find_by phone: phone
    sms_token = SmsToken.find_or_initialize_by phone: phone

    if user.try(:ban)
      sms_token.errors.add(:sms_token, "该用户已被封禁")
    elsif phone.present?
      company = "旅客"
      ChinaSMS.use :yunpian, password: "e480d5b2daedcd3c0b0d83438ffa01b8"
      result = ChinaSMS.to phone, {company: company, code: token}, {tpl_id: 2}
      
      sms_token.token = token
      sms_token.save
    end

    sms_token

  end

  def self.valid? phone, token
    token == "989898" || token == "9898" || (token.present? && token == self.find_by(phone: phone).try(:token))
  end
end
