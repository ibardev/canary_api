# == Schema Information
#
# Table name: user_infos
#
#  id                  :integer          not null, primary key
#  sex                 :integer
#  nickname            :string
#  birth               :date
#  dest_province       :string
#  dest_city           :string
#  province            :string
#  city                :string
#  contact_type        :integer
#  contact             :string
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  user_id             :integer
#  avatar_file_name    :string
#  avatar_content_type :string
#  avatar_file_size    :integer
#  avatar_updated_at   :datetime
#  slogan              :string
#  carreer             :integer
#  flight              :string
#  train               :string
#  hotel_type          :integer
#  oversea             :boolean
#
# Indexes
#
#  index_user_infos_on_sex      (sex)
#  index_user_infos_on_user_id  (user_id)
#

class UserInfosController < ApplicationController

  acts_as_token_authentication_handler_for User, except: [:check, :reset] 

  before_action :set_user_info, only: [:show, :edit, :update, :count, :destroy]

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
      @user_info = current_user.user_info
    end

    def user_info_params
      params.require(:user_info).permit(
        :sex, :nickname, :birth, :dest_province, :dest_city, :oversea,
        :province, :city, :contact_type, :contact, :slogan,
        :avatar, :carreer, :flight, :train, :hotel_type,
        cover_image_attributes: [:id, :photo, :_destroy]
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
