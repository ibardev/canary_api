# == Schema Information
#
# Table name: user_infos
#
#  id                  :integer          not null, primary key
#  sex                 :integer
#  nickname            :string
#  birth               :date
#  dest_province       :string
#  dest_city           :string
#  province            :string
#  city                :string
#  contact_type        :integer
#  contact             :string
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  user_id             :integer
#  avatar_file_name    :string
#  avatar_content_type :string
#  avatar_file_size    :integer
#  avatar_updated_at   :datetime
#  slogan              :string
#  carreer             :integer
#  flight              :string
#  train               :string
#  hotel_type          :integer
#
# Indexes
#
#  index_user_infos_on_sex      (sex)
#  index_user_infos_on_user_id  (user_id)
#

class UserInfo < ActiveRecord::Base
  
  acts_as_voter
  belongs_to :user

  enum sex: [:male, :female]
  enum contact_type: [:wechat, :qq]
  enum carreer: { student: 0, officer: 1, manager: 2, others: 3 }
  enum hotel_type: { economy: 2, comfortable: 3, commercial: 4, luxury: 5 }

  has_attached_file :avatar, styles: { mini: '48x48>', small: '100x100>', medium: '200x200>', product: '320x320>', large: '600x600>' } 
  validates_attachment_content_type :avatar, content_type: /image\/.*\Z/

  has_one :cover_image, -> { where photo_type: "cover" }, class_name: "Image", as: :imageable, dependent: :destroy

  delegate :phone, :sign_in_count, :current_sign_in_at, to: :user

  accepts_nested_attributes_for :cover_image, allow_destroy: true

  scope :same_sex, ->(sex) { where(sex: sex) }
  scope :opposite_sex, ->(sex) { where.not(sex: sex) }
  scope :local, ->(city) { where(city: city) }
  scope :foreign, ->(city) { where(dest_city: city) }
  scope :match, ->(city) { where("city = ? or dest_city = ?", city, city) }
  scope :current_sign_in_desc, -> { joins(:user).order('current_sign_in_at DESC') }

  def age
    return "" if birth.blank?
    now = Time.now.utc.to_date
    now.year - birth.year - (birth.to_date.change(year: now.year) > now ? 1 : 0)
  end

  def constellation
    return "" if birth.blank?
    
    year = birth.year
    mon = birth.mon
    day = birth.day

    if Date.new(year, 1, 21) <= birth && birth <= Date.new(year, 2, 19)
      "水瓶座"
    elsif Date.new(year, 2, 20) <= birth && birth <= Date.new(year, 3, 20)
      "双鱼座"
    elsif Date.new(year, 3, 21) <= birth && birth <= Date.new(year, 4, 20)
      "白羊座"
    elsif Date.new(year, 4, 21) <= birth && birth <= Date.new(year, 5, 21)
      "金牛座"
    elsif Date.new(year, 5, 22) <= birth && birth <= Date.new(year, 6, 21)
      "双子座"
    elsif Date.new(year, 6, 22) <= birth && birth <= Date.new(year, 7, 23)
      "巨蟹座"
    elsif Date.new(year, 7, 24) <= birth && birth <= Date.new(year, 8, 23)
      "狮子座"
    elsif Date.new(year, 8, 24) <= birth && birth <= Date.new(year, 9, 23)
      "处女座"
    elsif Date.new(year, 9, 24) <= birth && birth <= Date.new(year, 10, 23)
      "天秤座"
    elsif Date.new(year, 10, 24) <= birth && birth <= Date.new(year, 11, 22)
      "天蝎座"
    elsif Date.new(year, 11, 23) <= birth && birth <= Date.new(year, 12, 22)
      "射手座"
    else
      "摩羯座"
    end
  end
end
