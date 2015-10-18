# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string
#  last_sign_in_ip        :string
#  created_at             :datetime
#  updated_at             :datetime
#  authentication_token   :string
#  phone                  :string
#
# Indexes
#
#  index_users_on_authentication_token  (authentication_token)
#  index_users_on_email                 (email)
#  index_users_on_phone                 (phone) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#

require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_one(:user_info) } 

  describe "User collection" do
    let(:user) { create(:user) }
    let(:friend1) { create(:user_info) }
    let(:friend2) { create(:user_info) }

    it "should collected correctly" do
      expect(user.collected? friend1).to eq(false)
      user.collect! friend1

      expect(user.collected? friend1).to eq(true)
      expect(user.collected? friend2).to eq(false)
    end

    it "should uncollect correctly" do
      expect(user.collected? friend1).to eq(false)
      user.collect! friend1
      expect(user.collected? friend1).to eq(true)
      user.uncollect! friend1
      expect(user.collected? friend1).to eq(false)
    end

    it "should get collections correctly" do
      expect(user.collections.size).to eq(0)
      user.collect! friend1
      expect(user.collections.size).to eq(1)
      user.collect! friend1
      expect(user.collections.size).to eq(1)
      user.collect! friend2
      expect(user.collections.size).to eq(2)
      user.uncollect! friend2
      expect(user.collections.size).to eq(1)
    end
  end

  describe "User follow" do
    let(:user) { create(:user) }
    let(:friend1) { create(:user_info) }
    let(:friend2) { create(:user_info) }

    it "should follow correctly" do
      expect(user.followed? friend1).to eq(false)
      user.follow! friend1
      expect(user.followed? friend1).to eq(true)
      expect(user.followed? friend2).to eq(false)
    end

    it "should follow & collect correctly" do
      expect(user.followed? friend1).to eq(false)
      expect(user.collected? friend1).to eq(false)
      user.collect! friend1
      expect(user.followed? friend1).to eq(false)
      expect(user.collected? friend1).to eq(true)
      user.follow! friend1
      expect(user.followed? friend1).to eq(true)
      expect(user.collected? friend1).to eq(false)
    end

    it "should get followers correctly" do
      expect(user.followers.size).to eq(0)
      user.follow! friend1
      expect(user.followers.size).to eq(1)
      user.follow! friend1
      expect(user.followers.size).to eq(1)
      user.follow! friend2
      expect(user.followers.size).to eq(2)
    end

  end
end
