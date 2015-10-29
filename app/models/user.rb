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
# Indexes
#
#  index_users_on_authentication_token  (authentication_token)
#  index_users_on_email                 (email)
#  index_users_on_phone                 (phone) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#

class User < ActiveRecord::Base
  ## Token Authenticatable
  acts_as_token_authenticatable
  acts_as_votable

  attr_accessor :sms_token
  has_one :user_info, dependent: :destroy
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :trackable, :validatable,
  authentication_keys: [:phone]

  delegate :sex, :constellation, :age, :birth, :province, :city, :dest_province, :dest_city, :contact_type, :contact, :carreer, :hotel_type, to: :user_info

  validates_uniqueness_of :phone
  validates_presence_of :phone
  validates :phone, length: { is: 11 }

  validate :sms_token_validate

  after_create :add_user_info

  def name
    phone
  end

  def collect! friend
    self.liked_by friend, vote_scope: "collect"
  end

  def uncollect! friend
    self.unliked_by friend, vote_scope: "collect"
  end

  def collections
    self.get_likes(vote_scope: "collect").order('id DESC')
  end

  def collected? friend
    friend.voted_up_on? self, vote_scope: "collect"
  end

  def follow! friend
    self.uncollect! friend
    self.liked_by friend, vote_scope: "follow"
  end

  def followers
    self.get_likes(vote_scope: "follow").order('id DESC')
  end

  def can_followed?
    today_follow_count <= 3
  end

  def followed? friend
    friend.voted_up_on? self, vote_scope: "follow"
  end

  def complain_count
    Complain.where(source_compainer: user_info).count
  end

  def same_city? friend, local=true
    city = local ? self.try(:user_info).try(:city) : self.try(:user_info).try(:dest_city)
    city == friend.try(:city)
  end

  def sms_token_validate
    sms_token_obj = SmsToken.find_by(phone: phone)

    return if sms_token == "989898" || sms_token == "9898"

    if sms_token_obj.blank?
      self.errors.add(:sms_token, "验证码未获取，请先获取")
    elsif sms_token_obj.try(:updated_at) < Time.zone.now - 30.minute
      self.errors.add(:sms_token, "验证码已失效，请重新获取")
    elsif sms_token_obj.try(:token) != sms_token 
      self.errors.add(:sms_token, "验证码不正确，请重试")
    end
  end

  def today_follow_count
    self.followers.today.count
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
      user.errors.add(:phone, "手机号码对应的用户不存在")
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
