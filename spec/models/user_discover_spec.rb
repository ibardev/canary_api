# == Schema Information
#
# Table name: user_discovers
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_user_discovers_on_user_id  (user_id)
#

require 'rails_helper'

RSpec.describe UserDiscover, type: :model do
  it { should belong_to(:user) } 
end
