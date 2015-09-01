require 'acceptance_helper'

resource "朋友信息相关接口" do
  header "Accept", "application/json"
  header "Content-Type", "application/json"

  get "friends" do
    parameter :page, "页码", required: false
    parameter :per_page, "每页个数", required: false

    user_attrs = FactoryGirl.attributes_for(:user)
    user_info_attrs = FactoryGirl.attributes_for(:user_info)

    header "X-User-Token", user_attrs[:authentication_token]
    header "X-User-Phone", user_attrs[:phone]

    before do
      create(:user)
      create_list(:user_info, 3)
    end

    example "用户查询朋友相关列表信息成功" do
      do_request
      # puts response_body
      expect(status).to eq(200)
    end

  end

  get "friends/:id" do
    parameter :page, "页码", required: false
    parameter :per_page, "每页个数", required: false

    user_attrs = FactoryGirl.attributes_for(:user)
    user_info_attrs = FactoryGirl.attributes_for(:user_info)

    header "X-User-Token", user_attrs[:authentication_token]
    header "X-User-Phone", user_attrs[:phone]

    before do
      create(:user)
      @friend = create(:user_info)
    end
    let(:id) { @friend.id }

    example "查看具体朋友的详细信息成功" do
      do_request
      # puts response_body
      expect(status).to eq(200)  
    end
  end

  post "friends/:id/follow" do
    parameter :page, "页码", required: false
    parameter :per_page, "每页个数", required: false

    user_attrs = FactoryGirl.attributes_for(:user)
    user_info_attrs = FactoryGirl.attributes_for(:user_info)

    header "X-User-Token", user_attrs[:authentication_token]
    header "X-User-Phone", user_attrs[:phone]

    before do
      create(:user)
      @friend = create(:user_info)
    end
    let(:id) { @friend.id }


    example "申请查看朋友联系方式成功" do
      do_request
      # puts response_body
      expect(status).to eq(200)  
    end
  end

  get "friends/followed" do
    parameter :page, "页码", required: false
    parameter :per_page, "每页个数", required: false

    user_attrs = FactoryGirl.attributes_for(:user)
    user_info_attrs = FactoryGirl.attributes_for(:user_info)

    header "X-User-Token", user_attrs[:authentication_token]
    header "X-User-Phone", user_attrs[:phone]

    before do
      create(:user)
      create_list(:user_info, 3)
    end

    example "用户查询已联系的朋友列表信息成功" do
      do_request
      # puts response_body
      expect(status).to eq(200)
    end
  end

  get "friends/collected" do
    parameter :page, "页码", required: false
    parameter :per_page, "每页个数", required: false
    
    user_attrs = FactoryGirl.attributes_for(:user)
    user_info_attrs = FactoryGirl.attributes_for(:user_info)

    header "X-User-Token", user_attrs[:authentication_token]
    header "X-User-Phone", user_attrs[:phone]

    before do
      create(:user)
      create_list(:user_info, 3)
    end

    example "用户查询收藏的朋友列表信息成功" do
      do_request
      # puts response_body
      expect(status).to eq(200)
    end
  end

end