# == Schema Information
#
# Table name: banners
#
#  id         :integer          not null, primary key
#  title      :string
#  url        :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  position   :integer
#

FactoryGirl.define do
  factory :banner do
    title "Banner title"
    url "http://www.baidu.com"
    association :cover_image, factory: :image, photo_type: "cover"
  end

end
