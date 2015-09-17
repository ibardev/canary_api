require 'rails_helper'

RSpec.describe Discover, type: :model do
  it { should belong_to(:discoverable) } 
  it { should belong_to(:user) } 
end
