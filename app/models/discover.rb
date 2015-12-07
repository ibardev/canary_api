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
#  block             :boolean
#
# Indexes
#
#  index_discovers_on_block                                  (block)
#  index_discovers_on_discoverable_type_and_discoverable_id  (discoverable_type,discoverable_id)
#  index_discovers_on_user_id                                (user_id)
#

class Discover < ActiveRecord::Base
  belongs_to :discoverable, polymorphic: true
  belongs_to :user

  scope :unblock, -> { where.not(block: true) }
  scope :available, -> { joins(:user).where(users: { ban: [false, nil] }) }

  default_scope { order('created_at DESC') }
end
