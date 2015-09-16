require 'acceptance_helper'

resource "发现相关接口" do
  header "Accept", "application/json"
  header "Content-Type", "application/json"

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
    parameter :images_attributes, "邀约图片", required: true, scope: :invite_discover


    let(:begin_date) { invite_discover_attrs[:begin_date] }
    let(:end_date) { invite_discover_attrs[:end_date] }
    let(:content) { invite_discover_attrs[:content] }
    let(:images_attributes) { [image_attrs, image_attrs] }

    before do
      @user = create(:user)
      @user.user_info.update_attributes(user_info_attrs)
    end

    example "用户查询自己的信息成功" do
      do_request
      # puts response_body
      expect(status).to eq(200)
    end

  end

end