class InviteDiscoversController < ApplicationController

  acts_as_token_authentication_handler_for User

  before_action :set_invite_discover, only: [:show]
  before_action :set_self_invite_discover, only: [:edit, :update, :destroy]

  respond_to :html, :json

  def index
    @invite_discovers = InviteDiscover.all
    respond_with(@invite_discovers)
  end

  def show
    respond_with(@invite_discover)
  end

  def new
    @invite_discover = InviteDiscover.new
    respond_with(@invite_discover)
  end

  def edit
  end

  def create
    @invite_discover = InviteDiscover.new(invite_discover_params)
    @invite_discover.user = current_user
    @invite_discover.save
    respond_with(@invite_discover) do |format|
      format.json { render :show }
    end
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
      @invite_discover = InviteDiscover.find(params[:id])
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
end
