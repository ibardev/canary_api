# == Schema Information
#
# Table name: images
#
#  id                 :integer          not null, primary key
#  type               :string
#  photo_type         :string
#  imageable_id       :integer
#  imageable_type     :string
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  photo_file_name    :string
#  photo_content_type :string
#  photo_file_size    :integer
#  photo_updated_at   :datetime
#
# Indexes
#
#  index_images_on_imageable_type_and_imageable_id  (imageable_type,imageable_id)
#

FactoryGirl.define do
  
  factory :image do
    # title "MyString"
    photo_type "photo type"
    photo {Rack::Test::UploadedFile.new('./spec/asset/news.png', 'image/png')}
  end

end
