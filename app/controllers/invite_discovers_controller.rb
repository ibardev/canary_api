# == Schema Information
#
# Table name: invite_discovers
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  begin_date :date
#  end_date   :date
#  content    :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_invite_discovers_on_user_id  (user_id)
#

class InviteDiscoversController < ApplicationController

  acts_as_token_authentication_handler_for User, except: [:show] 

  wechat_api

  before_action :set_invite_discover, only: [:show, :respond, :unrespond, :responds, :append]
  before_action :set_self_invite_discover, only: [:edit, :update, :destroy]

  respond_to :html, :json

  def index
    @invite_discovers = InviteDiscover.all
    respond_with(@invite_discovers)
  end

  def show
    @title = "Ta在旅客App发起了一条邀约，快来响应吧！"
    if @invite_discover.blank?
      redirect_to root_path
    else
      @user_info = @invite_discover.try(:user).try(:user_info)
      respond_with(@invite_discover)
    end
  end

  def respond
    @invite_discover.respond current_user_info

    respond_with(@invite_discover, template: "invite_discovers/show")
  end

  def unrespond
    @invite_discover.unrespond current_user_info

    respond_with(@invite_discover, template: "invite_discovers/show")
  end

  def responds
    page = params[:page] || 1
    per_page = params[:per_page] || 10
    @invite_responds = @invite_discover.votes.paginate(page: page, per_page: per_page)
    @total_pages = @invite_responds.total_pages
    @current_page = @invite_responds.current_page
    @all_count = @invite_responds.count
    respond_with @invite_responds, template: "friends/invite_responds"
  end

  def new
    @invite_discover = InviteDiscover.new
    respond_with(@invite_discover)
  end

  def edit
  end

  def validate
    if !current_user.can_discover?
      render json: { errors: "一周内只能发一次邀约" }, status: 422
    elsif current_user.user_info.avatar.blank?
      render json: { errors: "请先上传头像" }, status: 422
    else
      render json: {}, status: 200
    end
  end

  def create
    if !current_user.can_discover?
      render json: { errors: "一周内只能发一次邀约" }, status: 422
    elsif current_user.user_info.avatar.blank?
      render json: { errors: "请先上传头像" }, status: 422
    else
      @invite_discover = InviteDiscover.new(invite_discover_params)
      @invite_discover.user = current_user
      @invite_discover.save
      respond_with(@invite_discover) do |format|
        format.json { render :show }
      end
    end
    
  end

  def append
    @invite_discover.images.build picture_params[:images_attributes]
    @invite_discover.save
    @invite_discover.reload
    respond_with(@invite_discover, template: "invite_discovers/show", status: 201)
  end

  def update
    @invite_discover.update(invite_discover_params)
    respond_with(@invite_discover)
  end

  def destroy
    @invite_discover.destroy
    respond_with(@invite_discover)
  end

  private
    def set_invite_discover
      @invite_discover = InviteDiscover.find_by(id: params[:id])
    end

    def set_self_invite_discover
      set_invite_discover
      if @invite_discover.user.id != current_user.id
        @invite_discover.errors.add(:user, "请使用发布该邀约的用户操作，谢谢！")
      end
    end

    def invite_discover_params
      params.require(:invite_discover).permit(
        :begin_date, :end_date, :content,
        images_attributes: [:id, :photo, :_destroy]
        )
    end

    def picture_params
      params.require(:invite_discover).permit(
        images_attributes: [:id, :photo, :_destroy]
        )
    end
end
