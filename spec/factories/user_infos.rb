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
#  oversea             :boolean
#
# Indexes
#
#  index_user_infos_on_sex      (sex)
#  index_user_infos_on_user_id  (user_id)
#

FactoryGirl.define do
  factory :user_info do
    sex 1
    nickname "nickname"
    birth "2015-08-13"
    dest_province "上海"
    dest_city "上海"
    province "福建"
    city "厦门"
    contact_type 1
    contact "12371236"
    # avatar File.open("./spec/asset/news.png", "rb").read
    avatar {Rack::Test::UploadedFile.new('./spec/asset/news.png', 'image/png')}
    slogan "用户签名"
    carreer "manager"
    flight "航班"
    train "列车次"
    hotel_type "luxury"
    oversea false
    association :cover_image, factory: :image
  end

end
