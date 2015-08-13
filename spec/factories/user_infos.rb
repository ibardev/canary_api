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
nickname "MyString"
birth "2015-08-13"
dest_province "MyString"
dest_city "MyString"
province "MyString"
city "MyString"
contact_type 1
contact "MyString"
  end

end
