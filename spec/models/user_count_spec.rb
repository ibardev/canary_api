# == Schema Information
#
# Table name: user_counts
#
#  id            :integer          not null, primary key
#  like_index    :integer
#  follow_index  :integer
#  respond_index :integer
#  user_id       :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
# Indexes
#
#  index_user_counts_on_user_id  (user_id)
#

require 'rails_helper'

RSpec.describe UserCount, type: :model do
  
end
