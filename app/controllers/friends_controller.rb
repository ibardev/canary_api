class FriendsController < ApplicationController

  acts_as_token_authentication_handler_for User, except: [:check, :reset] 

  before_action :set_friend, only: [:show, :follow, :collect, :uncollect]

  respond_to :html, :json

  def index
    page = params[:page] || 1
    per_page = params[:per_page] || 10
    @friends = UserInfo.opposite_sex(current_user_info.sex).paginate(page: page, per_page: per_page)
    respond_with(@friends)
  end

  def local
    page = params[:page] || 1
    per_page = params[:per_page] || 10
    @friends = UserInfo.opposite_sex(current_user_info.sex).local(current_user_info.city).paginate(page: page, per_page: per_page)
    respond_with(@friends) do |format|
      format.json { render :index }
    end
  end

  def foreign
    page = params[:page] || 1
    per_page = params[:per_page] || 10
    @friends = UserInfo.opposite_sex(current_user_info.sex).foreign(current_user_info.city).paginate(page: page, per_page: per_page)
    respond_with(@friends) do |format|
      format.json { render :index }
    end
  end

  def show
    respond_with(@friend)
  end

  def follow
    current_user.follow! @friend
    respond_with(@friend) do |format|
      format.json { render :show }
    end
  end

  def collect
    current_user.collect! @friend
    respond_with(@friend) do |format|
      format.json { render :show }
    end
  end

  def uncollect
    current_user.uncollect! @friend
    respond_with(@friend) do |format|
      format.json { render :show }
    end
  end

  def followed
    page = params[:page] || 1
    per_page = params[:per_page] || 10
    @friends = current_user.followers.paginate(page: page, per_page: per_page)
    respond_with(@friends) do |format|
      format.json { render :index }
    end
  end

  def collected
    page = params[:page] || 1
    per_page = params[:per_page] || 10
    @friends = current_user.collections.paginate(page: page, per_page: per_page)
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
