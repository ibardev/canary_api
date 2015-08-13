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

FactoryGirl.define do
  factory :user_info do
    sex 1
    nickname "测试名称"
    birth "2015-08-13"
    dest_province "上海"
    dest_city "上海"
    province "福建"
    city "厦门"
    contact_type 1
    contact "12371236"
  end

end
