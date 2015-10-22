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

require 'rails_helper'

RSpec.describe Complain, type: :model do
  it { should belong_to(:source_compainer) } 
  it { should belong_to(:dest_compainer) } 
end
