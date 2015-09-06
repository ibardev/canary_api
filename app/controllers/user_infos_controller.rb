class UserInfosController < ApplicationController

  acts_as_token_authentication_handler_for User, except: [:check, :reset] 

  before_action :set_user_info, only: [:show, :edit, :update, :destroy]

  respond_to :html, :json

  def check
    phone = check_params[:phone]
    @check_result = User.exists? phone: phone
    respond_with(@check_result)
  end

  def reset
    @user = User.reset_user_password reset_params 
    respond_with @user
  end

  def index
    @user_infos = UserInfo.all
    respond_with(@user_infos)
  end

  def show
    respond_with(@user_info)
  end

  def new
    @user_info = UserInfo.new
    respond_with(@user_info)
  end

  def edit
  end

  def create
    @user_info = UserInfo.new(user_info_params)
    @user_info.save
    respond_with(@user_info)
  end

  def update
    @user_info.update(user_info_params)
    respond_with(@user_info) do |format|
      format.json { render :show }
    end
  end

  def destroy
    @user_info.destroy
    respond_with(@user_info)
  end

  private
    def set_user_info
      if params[:user_info_id].present?
        @user_info = UserInfo.find(params[:id])
      else
        @user_info = current_user.user_info
      end
    end

    def user_info_params
      params.require(:user_info).permit(
        :sex, :nickname, :birth, :dest_province, :dest_city,
        :province, :city, :contact_type, :contact, :slogan,
        :avatar, :carreer, :flight, :train
        )
    end

    def check_params
      params.require(:user).permit(
        :phone
        )
    end

    def reset_params
      params.require(:user).permit(
        :phone, :password, :sms_token
        )
    end
end
