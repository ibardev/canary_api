require 'acceptance_helper'

resource "朋友信息相关接口" do
  header "Accept", "application/json"
  # header "Content-Type", "application/json"

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
      puts response_body
      expect(status).to eq(200)
    end

  end

  get "friends/:id" do

    user_attrs = FactoryGirl.attributes_for(:user)
    user_info_attrs = FactoryGirl.attributes_for(:user_info)

    header "X-User-Token", user_attrs[:authentication_token]
    header "X-User-Phone", user_attrs[:phone]

    before do
      @user = create(:user)
      @friend_user = create(:user, phone: "13850696686")
      @friend = create(:user_info, user: @friend_user)
    end
    let(:id) { @friend.id }

    example "查看具体朋友的详细信息成功" do
      do_request
      puts response_body
      expect(status).to eq(200)  
    end
  end

  post "friends/:id/follow" do

    user_attrs = FactoryGirl.attributes_for(:user)
    user_info_attrs = FactoryGirl.attributes_for(:user_info)

    header "X-User-Token", user_attrs[:authentication_token]
    header "X-User-Phone", user_attrs[:phone]

    before do
      create(:user)
      @friend_user = create(:user, phone: "13850696686")
      @friend = create(:user_info, user: @friend_user)
    end
    let(:id) { @friend.id }


    example "申请查看朋友联系方式成功" do
      do_request
      # puts response_body
      expect(status).to eq(200)  
    end
  end

  post "friends/:id/collect" do

    user_attrs = FactoryGirl.attributes_for(:user)
    user_info_attrs = FactoryGirl.attributes_for(:user_info)

    header "X-User-Token", user_attrs[:authentication_token]
    header "X-User-Phone", user_attrs[:phone]

    before do
      create(:user)
      @friend_user = create(:user, phone: "13850696686")
      @friend = create(:user_info, user: @friend_user)
    end
    let(:id) { @friend.id }


    example "申请收藏朋友成功" do
      do_request
      # puts response_body
      expect(status).to eq(200)  
    end
  end

  post "friends/:id/uncollect" do

    user_attrs = FactoryGirl.attributes_for(:user)
    user_info_attrs = FactoryGirl.attributes_for(:user_info)

    header "X-User-Token", user_attrs[:authentication_token]
    header "X-User-Phone", user_attrs[:phone]

    before do
      create(:user)
      @friend_user = create(:user, phone: "13850696686")
      @friend = create(:user_info, user: @friend_user)
    end
    let(:id) { @friend.id }


    example "取消收藏朋友成功" do
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
      puts response_body
      expect(status).to eq(200)
    end
  end

  post "friends/:id/like" do

    user_attrs = FactoryGirl.attributes_for(:user)
    user_info_attrs = FactoryGirl.attributes_for(:user_info)

    header "X-User-Token", user_attrs[:authentication_token]
    header "X-User-Phone", user_attrs[:phone]

    before do
      create(:user)
      @friend_user = create(:user, phone: "13850696686")
      @friend = create(:user_info, user: @friend_user)
    end
    let(:id) { @friend.id }


    example "用户赞朋友成功" do
      do_request
      puts response_body
      expect(status).to eq(200)  
    end
  end

  get "friends/liked" do
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

    example "用户赞过我的朋友列表信息成功" do
      do_request
      puts response_body
      expect(status).to eq(200)
    end
  end

  get "friends/followings" do
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

    example "用户联系我的朋友列表信息成功" do
      do_request
      puts response_body
      expect(status).to eq(200)
    end
  end

  get "friends/responders" do
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

    example "用户响应我的朋友列表信息成功" do
      do_request
      puts response_body
      expect(status).to eq(200)
    end
  end


  get "friends/local" do
    parameter :page, "页码", required: false
    parameter :per_page, "每页个数", required: false
    parameter :api_verison, "api版本", required: false

    user_attrs = FactoryGirl.attributes_for(:user)
    user_info_attrs = FactoryGirl.attributes_for(:user_info)

    header "X-User-Token", user_attrs[:authentication_token]
    header "X-User-Phone", user_attrs[:phone]

    before do
      create(:user)
      create_list(:user_info, 3)
    end

    example "用户获取本地用户列表成功" do
      do_request
      # puts response_body
      expect(status).to eq(200)
    end
  end

  get "friends/foreign" do
    parameter :page, "页码", required: false
    parameter :per_page, "每页个数", required: false
    parameter :api_verison, "api版本", required: false

    user_attrs = FactoryGirl.attributes_for(:user)
    user_info_attrs = FactoryGirl.attributes_for(:user_info)

    header "X-User-Token", user_attrs[:authentication_token]
    header "X-User-Phone", user_attrs[:phone]

    before do
      create(:user)
      create_list(:user_info, 3)
    end

    example "用户获取异地用户列表成功" do
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

  post "friends/:id/complains" do
    parameter :reason, "投诉原因【fake, low, porn, rubbish】", required: true, scope: :complain
    parameter :comment, "投诉说明", required: false, scope: :complain

    user_attrs = FactoryGirl.attributes_for(:user)
    user_info_attrs = FactoryGirl.attributes_for(:user_info)

    header "X-User-Token", user_attrs[:authentication_token]
    header "X-User-Phone", user_attrs[:phone]

    before do
      @source_compainer = create(:user)
      @dest_complainer = create(:user_info)
    end

    let(:reason) { "fake" }
    let(:comment) { "This is a comment!" }
    let(:id) { 1 }

    example "投诉相关人员成功" do
      do_request
      puts response_body
      expect(status).to eq(201)
    end

  end

  get "friends/count" do
    user_attrs = FactoryGirl.attributes_for(:user)
    user_info_attrs = FactoryGirl.attributes_for(:user_info)

    header "X-User-Token", user_attrs[:authentication_token]
    header "X-User-Phone", user_attrs[:phone]

    before do
      create(:user)
    end
    
    example "获取用户对应朋友列表的统计信息" do
      do_request
      puts response_body
      expect(status).to eq(200)
    end
  end


  get "friends/:friend_id/pictures" do
    user_attrs = FactoryGirl.attributes_for(:user)
    user_info_attrs = FactoryGirl.attributes_for(:user_info)

    header "X-User-Token", user_attrs[:authentication_token]
    header "X-User-Phone", user_attrs[:phone]

    before do
      @user = create(:user)
      @friend_user = create(:user, phone: "13850696686")
      @friend = create(:user_info, user: @friend_user)
      @friend_user.user_info.pictures.create(FactoryGirl.attributes_for(:image, photo_type: "pic"))
      @friend_user.user_info.pictures.create(FactoryGirl.attributes_for(:image, photo_type: "pic"))
    end
    let(:friend_id) { @friend.id }

    example "查看具体朋友的详细信息成功" do
      do_request
      puts response_body
      expect(status).to eq(200)  
    end
  end

  get 'friends/:friend_id/discovers' do
    user_attrs = FactoryGirl.attributes_for(:user)
    user_info_attrs = FactoryGirl.attributes_for(:user_info)

    header "X-User-Token", user_attrs[:authentication_token]
    header "X-User-Phone", user_attrs[:phone]

    before do
      @user = create(:user)
      @user.user_info.update_attributes(user_info_attrs)
      @friend_user = create(:user, phone: "13850696686")
      @friend = create(:user_info, user: @friend_user)
      @invite_discovers = create_list(:invite_discover, 3, user: @friend_user)
    end
    let(:friend_id) { @friend.id }

    example "获取朋友的发现列表成功" do
      do_request
      puts response_body
      expect(status).to eq(200)
    end
  end

end