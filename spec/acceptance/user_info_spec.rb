# encoding: utf-8

require 'acceptance_helper'

resource "用户相关接口" do
  header "Accept", "application/json"
  # header "Content-Type", "application/json"

  get "user_info" do
    user_attrs = FactoryGirl.attributes_for(:user)
    user_info_attrs = FactoryGirl.attributes_for(:user_info)

    header "X-User-Token", user_attrs[:authentication_token]
    header "X-User-Phone", user_attrs[:phone]

    before do
      @user = create(:user)
      @user.user_info.update_attributes(user_info_attrs)
    end

    example "用户查询自己的信息成功" do
      do_request
      puts response_body
      expect(status).to eq(200)
    end

  end

  put "user_info" do
    user_attrs = FactoryGirl.attributes_for(:user)
    user_info_attrs = FactoryGirl.attributes_for(:user_info)
    image_attrs = FactoryGirl.attributes_for(:image, photo_type: "cover")

    header "X-User-Token", user_attrs[:authentication_token]
    header "X-User-Phone", user_attrs[:phone]

    parameter :nickname, "昵称", required: false, scope: :user_info
    parameter :birth, "生日", required: false, scope: :user_info
    parameter :sex, "性别【男: male, 女: female】", required: false, scope: :user_info
    parameter :oversea, "是否国际", required: false, scope: :user_info
    parameter :dest_province, "目的地省份", required: false, scope: :user_info
    parameter :dest_city, "目的地城市", required: false, scope: :user_info
    parameter :province, "所在省份", required: false, scope: :user_info
    parameter :city, "所在城市", required: false, scope: :user_info
    parameter :contact_type, "联系类型", required: false, scope: :user_info
    parameter :contact, "联系方式", required: false, scope: :user_info
    parameter :slogan, "用户签名", required: false, scope: :user_info
    parameter :avatar, "用户头像", required: false, scope: :user_info
    parameter :carreer, "用户职业【学生: student, 职员: officer, 高管: manager, 其他: others】", required: false, scope: :user_info
    parameter :flight, "航班号", required: false, scope: :user_info
    parameter :train, "高铁车次", required: false, scope: :user_info
    parameter :hotel_type, "酒店类型【经济型连锁: economy, 三星级舒适: comfortable, 四星级高档: commercial, 五星级豪华: luxury】", required: false, scope: :user_info
    parameter :cover_image_attributes, "封面背景", required: false, scope: :user_info

    let(:nickname) { "测试名称" }
    let(:birth) {"2008-5-28"}
    let(:sex) {"female"}
    let(:oversea) {false}
    let(:dest_province) {"上海"}
    let(:dest_city) {"上海"}
    let(:province) {"江苏"}
    let(:city) {"南京"}
    let(:contact_type) {"wechat"}
    let(:contact) {"1123123"}
    let(:slogan) {"用户签名"}
    # let(:avatar) { user_info_attrs[:avatar] }
    let(:carreer) { "student" }
    let(:flight) { "航班号" }
    let(:train) { "高铁车次" }
    let(:hotel_type) { "luxury" }
    let(:cover_image_attributes) { image_attrs }
    # let(:raw_post) { params.to_json }

    before do
      @user = create(:user)
    end

    example "用户修改自己的信息成功" do
      # puts params
      do_request
      puts response_body
      expect(status).to eq(200)
    end
  end

  post 'user_info/modify' do
    user_attrs = FactoryGirl.attributes_for(:user)
    user_info_attrs = FactoryGirl.attributes_for(:user_info)
    image_attrs = FactoryGirl.attributes_for(:image, photo_type: "cover")

    header "X-User-Token", user_attrs[:authentication_token]
    header "X-User-Phone", user_attrs[:phone]

    parameter :nickname, "昵称", required: false, scope: :user_info
    parameter :birth, "生日", required: false, scope: :user_info
    parameter :sex, "性别【男: male, 女: female】", required: false, scope: :user_info
    parameter :oversea, "是否国际", required: false, scope: :user_info
    parameter :dest_province, "目的地省份", required: false, scope: :user_info
    parameter :dest_city, "目的地城市", required: false, scope: :user_info
    parameter :province, "所在省份", required: false, scope: :user_info
    parameter :city, "所在城市", required: false, scope: :user_info
    parameter :contact_type, "联系类型", required: false, scope: :user_info
    parameter :contact, "联系方式", required: false, scope: :user_info
    parameter :slogan, "用户签名", required: false, scope: :user_info
    parameter :avatar, "用户头像", required: false, scope: :user_info
    parameter :carreer, "用户职业【学生: student, 职员: officer, 高管: manager, 其他: others】", required: false, scope: :user_info
    parameter :flight, "航班号", required: false, scope: :user_info
    parameter :train, "高铁车次", required: false, scope: :user_info
    parameter :hotel_type, "酒店类型【经济型连锁: economy, 三星级舒适: comfortable, 四星级高档: commercial, 五星级豪华: luxury】", required: false, scope: :user_info
    parameter :cover_image_attributes, "封面背景", required: false, scope: :user_info

    let(:nickname) { "测试名称" }
    let(:birth) {"2008-5-28"}
    let(:sex) {"female"}
    let(:oversea) {false}
    let(:dest_province) {"上海"}
    let(:dest_city) {"上海"}
    let(:province) {"江苏"}
    let(:city) {"南京"}
    let(:contact_type) {"wechat"}
    let(:contact) {"1123123"}
    let(:slogan) {"用户签名"}
    # let(:avatar) { user_info_attrs[:avatar] }
    let(:carreer) { "student" }
    let(:flight) { "航班号" }
    let(:train) { "高铁车次" }
    let(:hotel_type) { "luxury" }
    let(:cover_image_attributes) { image_attrs }

    before do
      @user = create(:user)
    end

    example "用户修改头像成功" do
      do_request
      puts response_body
      expect(status).to eq(200)
    end


  end

  get 'user_info/pictures' do
    user_attrs = FactoryGirl.attributes_for(:user)
    user_info_attrs = FactoryGirl.attributes_for(:user_info)
    header "X-User-Token", user_attrs[:authentication_token]
    header "X-User-Phone", user_attrs[:phone]

    before do
      @user = create(:user)
      @user.user_info.pictures.create(FactoryGirl.attributes_for(:image, photo_type: "pic"))
      @user.user_info.pictures.create(FactoryGirl.attributes_for(:image, photo_type: "pic"))
    end

    example "获取用户的照片墙信息" do
      do_request
      puts response_body
      expect(status).to eq(200)
    end

  end

  post 'user_info/pictures' do
    user_attrs = FactoryGirl.attributes_for(:user)
    user_info_attrs = FactoryGirl.attributes_for(:user_info)
    header "X-User-Token", user_attrs[:authentication_token]
    header "X-User-Phone", user_attrs[:phone]
    image_attrs = FactoryGirl.attributes_for(:image, photo_type: "pic")

    parameter :pictures_attributes, "个人照片墙图片", require: true

    # let(:pictures_attributes) { [image_attrs, image_attrs] }
    before do
      @user = create(:user)
      @user.user_info.pictures.create(FactoryGirl.attributes_for(:image, photo_type: "pic"))
    end

    example "用户更新个人照片墙图片" do
      do_request
      puts response_body
      expect(status).to eq(201)
    end
  end

  post 'user_info/pictures/append' do
    user_attrs = FactoryGirl.attributes_for(:user)
    user_info_attrs = FactoryGirl.attributes_for(:user_info)
    header "X-User-Token", user_attrs[:authentication_token]
    header "X-User-Phone", user_attrs[:phone]
    image_attrs = FactoryGirl.attributes_for(:image, photo_type: "pic")

    parameter :pictures_attributes, "个人照片墙添加图片（单张）", require: true

    # let(:pictures_attributes) { image_attrs }
    before do
      @user = create(:user)
      @user.user_info.pictures.create(FactoryGirl.attributes_for(:image, photo_type: "pic"))
    end

    example "用户更新个人照片墙图片" do
      do_request
      puts response_body
      expect(status).to eq(201)
    end
  end

  post 'user_info/pictures/delete' do
    user_attrs = FactoryGirl.attributes_for(:user)
    user_info_attrs = FactoryGirl.attributes_for(:user_info)
    header "X-User-Token", user_attrs[:authentication_token]
    header "X-User-Phone", user_attrs[:phone]

    parameter :ids, "删除的照片id列表（需要从列表获得）", require: true, scope: :pictures

    before do
      @user = create(:user)
      @user.user_info.pictures.create(FactoryGirl.attributes_for(:image, photo_type: "pic"))
      @user.user_info.pictures.create(FactoryGirl.attributes_for(:image, photo_type: "pic"))
      @user.user_info.pictures.create(FactoryGirl.attributes_for(:image, photo_type: "pic"))
    end
    let(:ids) { [1,2] }

    example "删除指定照片墙信息" do
      do_request
      puts response_body
      expect(status).to eq(201)
    end

  end

  get 'user_info/discovers' do
    user_attrs = FactoryGirl.attributes_for(:user)
    user_info_attrs = FactoryGirl.attributes_for(:user_info)

    header "X-User-Token", user_attrs[:authentication_token]
    header "X-User-Phone", user_attrs[:phone]

    before do
      @user = create(:user)
      @user.user_info.update_attributes(user_info_attrs)
      @invite_discovers = create_list(:invite_discover, 3, user: @user)
    end

    example "用户获取自己的发现列表成功" do
      do_request
      puts response_body
      expect(status).to eq(200)
    end
  end

  get 'user_info/messages' do
    parameter :page, "页码", required: false
    parameter :per_page, "每页个数", required: false

    user_attrs = FactoryGirl.attributes_for(:user)
    user_info_attrs = FactoryGirl.attributes_for(:user_info)

    header "X-User-Token", user_attrs[:authentication_token]
    header "X-User-Phone", user_attrs[:phone]

    let(:page) { 1 }
    let(:per_page) { 10 }

    before do
      @user = create(:user)
      @user.user_info.update_attributes(user_info_attrs)
      @messages = create_list(:message, 3)
    end

    example "用户获取消息列表成功" do
      do_request
      puts response_body
      expect(status).to eq(200)
    end
  end

end