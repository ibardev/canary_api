class Wechat::SessionsController < ApplicationController
  before_action :set_wechat_session, only: [:show, :edit, :update, :destroy]

  respond_to :json

  def create
    openid = wechat_session_params[:openid]
    user = User.find_by(phone: openid) || User.create(phone: openid, password: "12341234", sms_token: "1981")
    render json: {phone: user.phone, authentication_token: user.authentication_token}, status: 201
  end

  private
    def wechat_session_params
      params.require(:wechat).permit(
        :openid
        )
    end
end
