class Discover < ActiveRecord::Base
  belongs_to :discoverable, polymorphic: true
  belongs_to :user
end
