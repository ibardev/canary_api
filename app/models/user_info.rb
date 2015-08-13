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
end
