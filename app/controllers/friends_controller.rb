class FriendsController < ApplicationController

  acts_as_token_authentication_handler_for User, except: [:check, :reset] 

  before_action :set_friend, only: [:show, :follow, :collect]

  respond_to :html, :json

  def index
    @friends = UserInfo.all
    respond_with(@friends)
  end

  def show
    respond_with(@friend)
  end

  def follow
    respond_with(@friend) do |format|
      format.json { render :show }
    end
  end

  def collect
    respond_with(@friend) do |format|
      format.json { render :show }
    end
  end

  def followed
    @friends = UserInfo.all
    respond_with(@friends) do |format|
      format.json { render :index }
    end
  end

  def collected
    @friends = UserInfo.all
    respond_with(@friends) do |format|
      format.json { render :index }
    end
  end

  def new
    @friend = Friend.new
    respond_with(@friend)
  end

  def edit
  end

  def create
    @friend = Friend.new(friend_params)
    @friend.save
    respond_with(@friend)
  end

  def update
    @friend.update(friend_params)
    respond_with(@friend)
  end

  def destroy
    @friend.destroy
    respond_with(@friend)
  end

  private
    def set_friend
      @friend = UserInfo.find(params[:id])
    end

    def friend_params
      params[:friend]
    end
end
