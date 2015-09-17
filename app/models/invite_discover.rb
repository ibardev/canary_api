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

  def as_json options=nil
    {
      begin_date: begin_date,
      end_date: end_date,
      content: content,
      images: 
        images.map do |image|
          {
            small: image.photo.url(:small),
            big: image.photo.url(:big)
          }
        end
    }
  end

  private
    def add_discover
      self.create_discover user: user
    end
end
