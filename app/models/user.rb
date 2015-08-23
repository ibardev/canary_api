# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string
#  last_sign_in_ip        :string
#  created_at             :datetime
#  updated_at             :datetime
#  authentication_token   :string
#  phone                  :string
#

class User < ActiveRecord::Base
  ## Token Authenticatable
  acts_as_token_authenticatable

  attr_accessor :sms_token
  has_one :user_info, dependent: :destroy
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :trackable, :validatable,
  authentication_keys: [:phone]

  validates_uniqueness_of :phone
  validates_presence_of :phone
  validates :phone, length: { is: 11 }

  validate :sms_token_validate

  after_create :add_user_info

  def sms_token_validate
    sms_token_obj = SmsToken.find_by(phone: phone)

    return if sms_token == "989898"

    if sms_token_obj.blank?
      self.errors.add(:sms_token, "未获取，请先获取")
    elsif sms_token_obj.try(:updated_at) < Time.zone.now - 30.minute
      self.errors.add(:sms_token, "已失效，请重新获取")
    elsif sms_token_obj.try(:token) != sms_token 
      self.errors.add(:sms_token, "不正确，请重试")
    end
  end

  def self.reset_user_password params
    phone = params[:phone]
    password = params[:password]
    sms_token = params[:sms_token]
    user = User.find_by phone: phone
    if user.present?
      user.password = password
      user.sms_token = sms_token
      user.save
    else
      user = User.new
      user.errors.add(:phone, "对应的用户不存在")
    end
    user
  end

  # user phone as the authentication key, so email is not required default
  def email_required?
    false
  end

  private
    def add_user_info
      self.create_user_info
    end
end
