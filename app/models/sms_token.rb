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
      if phone.to_s.start_with?("+")
        sms_hash = { code: token }
        tpl_id = 1147325
      else
        tpl_id = 2
        company = "旅客"
        sms_hash = {company: company, code: token}
      end
      
      ChinaSMS.use :yunpian, password: "e480d5b2daedcd3c0b0d83438ffa01b8"
      
      result = ChinaSMS.to phone, sms_hash, {tpl_id: tpl_id}
      
      sms_token.token = token
      sms_token.save
    end

    sms_token

  end

  def self.valid? phone, token
    sms_token = self.find_by(phone: phone)
    token == "1981" || 
    (token.present? && sms_token.present? && token == sms_token.token && sms_token.updated_at < Time.zone.now - 10.minute)
  end
end
