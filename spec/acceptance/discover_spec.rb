require 'acceptance_helper'

resource "发现相关接口" do
  header "Accept", "application/json"
  # header "Content-Type", "application/json"

  post "invite_discovers" do
    user_attrs = FactoryGirl.attributes_for(:user)
    user_info_attrs = FactoryGirl.attributes_for(:user_info)
    image_attrs = FactoryGirl.attributes_for(:image)

    invite_discover_attrs = FactoryGirl.attributes_for(:invite_discover)

    header "X-User-Token", user_attrs[:authentication_token]
    header "X-User-Phone", user_attrs[:phone]

    parameter :begin_date, "邀约开始日期", required: true, scope: :invite_discover
    parameter :end_date, "邀约结束日期", required: true, scope: :invite_discover
    parameter :content, "邀约内容", required: true, scope: :invite_discover
    parameter :images_attributes, "邀约图片", required: false, scope: :invite_discover


    let(:begin_date) { invite_discover_attrs[:begin_date] }
    let(:end_date) { invite_discover_attrs[:end_date] }
    let(:content) { invite_discover_attrs[:content] }
    # let(:images_attributes) { [image_attrs, image_attrs] }
    # let(:images_attributes) { [image_attrs] }

    before do
      @user = create(:user)
      @user.user_info.update_attributes(user_info_attrs)
    end

    example "用户发布邀约成功" do
      do_request
      # puts response_body
      expect(status).to eq(200)
    end

  end

  get "discovers" do
    user_attrs = FactoryGirl.attributes_for(:user)
    user_info_attrs = FactoryGirl.attributes_for(:user_info)

    header "X-User-Token", user_attrs[:authentication_token]
    header "X-User-Phone", user_attrs[:phone]

    before do
      @user = create(:user)
      @user.user_info.update_attributes(user_info_attrs)
      @invite_discovers = create_list(:invite_discover, 3, user: @user)
      @user_discovers = create_list(:user_discover, 3, user: @user)
    end

    example "用户获取发现列表成功" do
      do_request
      # puts response_body
      expect(status).to eq(200)
    end

  end

  delete "invite_discovers/:id" do
    user_attrs = FactoryGirl.attributes_for(:user)
    user_info_attrs = FactoryGirl.attributes_for(:user_info)

    header "X-User-Token", user_attrs[:authentication_token]
    header "X-User-Phone", user_attrs[:phone]

    before do
      @user = create(:user)
      @user.user_info.update_attributes(user_info_attrs)
      @invite_discovers = create_list(:invite_discover, 3, user: @user)
      @user_discovers = create_list(:user_discover, 3, user: @user)
    end

    let(:id) { @invite_discovers.first.id }
    example "用户删除邀约成功" do
      do_request
      puts response_body
      expect(status).to eq(204)
    end
  end

  delete "invite_discovers/:id" do
    user_attrs = FactoryGirl.attributes_for(:user)
    user_info_attrs = FactoryGirl.attributes_for(:user_info)

    header "X-User-Token", user_attrs[:authentication_token]
    header "X-User-Phone", user_attrs[:phone]

    before do
      @user = create(:user, phone: "13813813812", authentication_token: "adfkljasdf")
      @user1 = create(:user)
      @user.user_info.update_attributes(user_info_attrs)
      @invite_discovers = create_list(:invite_discover, 3, user: @user)
      @user_discovers = create_list(:user_discover, 3, user: @user)
    end

    let(:id) { @invite_discovers.first.id }
    example "用户删除邀约失败，不允许删除其他用户的邀约" do
      do_request
      puts response_body
      expect(status).to eq(422)
    end
  end

  post "invite_discovers/:id/respond" do
    user_attrs = FactoryGirl.attributes_for(:user)
    user_info_attrs = FactoryGirl.attributes_for(:user_info)

    header "X-User-Token", user_attrs[:authentication_token]
    header "X-User-Phone", user_attrs[:phone]

    before do
      @user = create(:user, phone: "13813813812", authentication_token: "adfkljasdf")
      @user1 = create(:user)
      @user.user_info.update_attributes(user_info_attrs)
      @invite_discovers = create_list(:invite_discover, 3, user: @user)
    end

    let(:id) { @invite_discovers.first.id }
    example "用户相应某一条邀约" do
      do_request
      puts response_body
      expect(status).to eq(200)
    end
  end

  get "banners" do
    before do
      create_list(:banner, 3)
    end

    example "获取banner列表成功" do
      do_request
      puts response_body
      expect(status).to eq(200)
    end
  end


end