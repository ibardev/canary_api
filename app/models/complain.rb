# == Schema Information
#
# Table name: complains
#
#  id         :integer          not null, primary key
#  source_id  :integer
#  dest_id    :integer
#  reason     :integer
#  comment    :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_complains_on_dest_id    (dest_id)
#  index_complains_on_source_id  (source_id)
#

class Complain < ActiveRecord::Base
  enum reason: [:fake, :low, :porn, :rubbish]

  belongs_to :source_compainer, class_name: "UserInfo", foreign_key: "source_id"
  belongs_to :dest_compainer, class_name: "UserInfo", foreign_key: "dest_id"
end
