# == Schema Information
#
# Table name: invite_discovers
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  begin_date :date
#  end_date   :date
#  content    :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_invite_discovers_on_user_id  (user_id)
#

class InviteDiscover < ActiveRecord::Base
  belongs_to :user
  has_many :images, as: :imageable, dependent: :destroy
  has_one :discover, as: :discoverable, dependent: :destroy
  after_create :add_discover

  accepts_nested_attributes_for :images

  def block!
    self.discover.block = true
    self.discover.save
  end

  def unblock!
    self.discover.block = false
    self.discover.save
  end

  def block
    self.discover.try(:block)
  end

  def as_json options=nil
    {
      begin_date: begin_date,
      end_date: end_date,
      content: content,
      images: 
        images.map do |image|
          {
            small: image.photo.url(:small),
            big: image.photo.url(:product)
          }
        end
    }
  end

  private
    def add_discover
      self.create_discover user: user, block: false
    end
end
