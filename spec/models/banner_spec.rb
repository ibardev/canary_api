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

require 'rails_helper'

RSpec.describe Banner, type: :model do
  
end
