# == Schema Information
#
# Table name: discovers
#
#  id                :integer          not null, primary key
#  discoverable_id   :integer
#  discoverable_type :string
#  user_id           :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#
# Indexes
#
#  index_discovers_on_discoverable_type_and_discoverable_id  (discoverable_type,discoverable_id)
#  index_discovers_on_user_id                                (user_id)
#

require 'rails_helper'

RSpec.describe Discover, type: :model do
  it { should belong_to(:discoverable) } 
  it { should belong_to(:user) } 
end
