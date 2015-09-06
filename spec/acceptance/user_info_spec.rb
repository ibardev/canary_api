require 'acceptance_helper'

resource "用户相关接口" do
  header "Accept", "application/json"
  header "Content-Type", "application/json"

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
      expect(status).to eq(200)
    end

  end

  put "user_info" do
    user_attrs = FactoryGirl.attributes_for(:user)
    user_info_attrs = FactoryGirl.attributes_for(:user_info)

    header "X-User-Token", user_attrs[:authentication_token]
    header "X-User-Phone", user_attrs[:phone]

    parameter :nickname, "昵称", required: false, scope: :user_info
    parameter :birth, "生日", required: false, scope: :user_info
    parameter :sex, "性别【男: male, 女: female】", required: false, scope: :user_info
    parameter :dest_province, "目的地省份", required: false, scope: :user_info
    parameter :dest_city, "目的地城市", required: false, scope: :user_info
    parameter :province, "所在省份", required: false, scope: :user_info
    parameter :city, "所在城市", required: false, scope: :user_info
    parameter :contact_type, "联系类型", required: false, scope: :user_info
    parameter :contact, "联系方式", required: false, scope: :user_info
    parameter :slogan, "用户签名", required: false, scope: :user_info
    parameter :avatar, "用户头像", required: false, scope: :user_info
    parameter :carreer, "用户职业【学生: student, 职员: officer, 高管: manager, 其他: other】", required: false, scope: :user_info
    parameter :flight, "航班号", required: false, scope: :user_info
    parameter :train, "高铁车次", required: false, scope: :user_info

    let(:nickname) { "测试名称" }
    let(:birth) {"2008-5-28"}
    let(:sex) {"female"}
    let(:dest_province) {"上海"}
    let(:dest_city) {"上海"}
    let(:province) {"江苏"}
    let(:city) {"南京"}
    let(:contact_type) {"wechat"}
    let(:contact) {"1123123"}
    let(:slogan) {"用户签名"}
    let(:avatar) { user_info_attrs[:avatar] }
    let(:carreer) { "student" }
    let(:flight) { "航班号" }
    let(:train) { "高铁车次" }
    # let(:raw_post) { params.to_json }

    before do
      @user = create(:user)
    end

    example "用户修改自己的信息成功" do
      do_request
      # puts response_body
      expect(status).to eq(200)
    end
  end

end