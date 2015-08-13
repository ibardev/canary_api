# == Schema Information
#
# Table name: user_infos
#
#  id            :integer          not null, primary key
#  sex           :integer
#  nickname      :string
#  birth         :date
#  dest_province :string
#  dest_city     :string
#  province      :string
#  city          :string
#  contact_type  :integer
#  contact       :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  user_id       :integer
#

class UserInfo < ActiveRecord::Base
  belongs_to :user

  enum sex: [:male, :female]
  enum contact_type: [:wechat, :qq]

  def age
    return "" if birth.blank?
    now = Time.now.utc.to_date
    now.year - birth.year - (birth.to_date.change(:year => now.year) > now ? 1 : 0)
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
