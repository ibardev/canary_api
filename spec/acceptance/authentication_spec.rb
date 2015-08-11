require 'acceptance_helper'

resource "用户注册登录" do
  header "Accept", "application/json"
  header "Content-Type", "application/json"

  post "/users" do
    parameter :phone, "用户注册的手机号码", required: true, scope: :user
    parameter :password, "用户注册的密码", required: true, scope: :user
    parameter :sms_token, "用户注册的短消息验证码", required: true, scope: :user

    user_attrs = FactoryGirl.attributes_for :user
    sms_attrs = FactoryGirl.attributes_for :sms_token

    describe "用户注册成功" do
      let(:phone) { sms_attrs[:phone] }
      let(:password) { user_attrs[:password] }
      let(:sms_token) { sms_attrs[:token] }
      let(:raw_post) { params.to_json }

      response_field :id, "用户ID"
      response_field :email, "邮箱"
      response_field :created_at, "创建时间"
      response_field :updated_at, "更新时间"
      response_field :phone, "电话号码"
      response_field :authentication_token, "鉴权Token"

      example "用户注册成功" do
        create :sms_token
        do_request
        puts response_body
        expect(status).to eq(201)
      end
    end

    describe "用户注册失败" do
      let(:phone) { sms_attrs[:phone] }
      let(:password) { user_attrs[:password] }
      let(:sms_token) { sms_attrs[:token] }
      let(:raw_post) { params.to_json }

      example "用户注册失败（验证码未获取）" do
        do_request
        puts response_body
        expect(status).to eq(422)
      end

      let(:phone) { sms_attrs[:phone] }
      let(:password) { user_attrs[:password] }
      let(:sms_token) { "323232" }
      let(:raw_post) { params.to_json }

      example "用户注册失败（验证码错误）" do
        create :sms_token
        do_request
        puts response_body
        expect(status).to eq(422)
      end

    end

  end

  post "/users/sign_in" do

    before do
      @user = create(:user)
    end

    parameter :phone, "登录的手机号", required: true, scope: :user
    parameter :password, "登录密码", required: true, scope: :user

    user_attrs = FactoryGirl.attributes_for :user
    let(:phone) { user_attrs[:phone] }
    let(:password) { user_attrs[:password] }
    let(:raw_post) { params.to_json }

    response_field :id, "用户ID"
    response_field :email, "邮箱"
    response_field :created_at, "创建时间"
    response_field :updated_at, "更新时间"
    response_field :phone, "电话号码"
    response_field :authentication_token, "鉴权Token"

    example "用户登录成功" do
      do_request
      puts response_body
      expect(status).to eq(201)
    end
  end

end