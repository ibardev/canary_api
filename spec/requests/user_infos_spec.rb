require 'rails_helper'

RSpec.describe "UserInfos", type: :request do
  describe "GET /user_infos" do
    it "works! (now write some real specs)" do
      get user_infos_path
      expect(response).to have_http_status(200)
    end
  end
end
