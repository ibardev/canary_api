class FriendsController < ApplicationController

  acts_as_token_authentication_handler_for User

  before_action :set_friend, only: [:show, :follow, :collect, :uncollect, :info, :like]

  respond_to :html, :json

  def index
    page = params[:page] || 1
    per_page = params[:per_page] || 10
    city = current_user_info.city
    @friends = UserInfo.available.opposite_sex(current_user_info[:sex]).match(city).current_sign_in_desc.paginate(page: page, per_page: per_page)
    @local_count = UserInfo.available.opposite_sex(current_user_info[:sex]).local(city).count
    @foreign_count = @friends.count - @local_count
    respond_with(@friends)
  end

  def local
    page = params[:page] || 1
    per_page = params[:per_page] || 10
    query_type = params[:type] || "all"
    @local = true
    if query_type == "local"
      @friends = UserInfo.available.opposite_sex(current_user_info[:sex]).local(current_user_info.city).current_sign_in_desc.paginate(page: page, per_page: per_page)
    elsif query_type == "foreign"
      @friends = UserInfo.available.opposite_sex(current_user_info[:sex]).foreign(current_user_info.city).current_sign_in_desc.paginate(page: page, per_page: per_page)
    else
      @friends = UserInfo.available.opposite_sex(current_user_info[:sex]).match(current_user_info.city).current_sign_in_desc.paginate(page: page, per_page: per_page)
      @local_count = UserInfo.available.opposite_sex(current_user_info[:sex]).local(current_user_info.city).count
      @all_count = @friends.count
      @foreign_count = @all_count - @local_count
    end
    @all_count = @friends.count
    respond_with(@friends) do |format|
      format.json { render :index }
    end
  end

  def foreign
    page = params[:page] || 1
    per_page = params[:per_page] || 10
    query_type = params[:type] || "all"
    @local = false
    if query_type == "local"
      @friends = UserInfo.available.opposite_sex(current_user_info[:sex]).local(current_user_info.dest_city).current_sign_in_desc.paginate(page: page, per_page: per_page)
    elsif query_type == "foreign"
      @friends = UserInfo.available.opposite_sex(current_user_info[:sex]).foreign(current_user_info.dest_city).current_sign_in_desc.paginate(page: page, per_page: per_page)
    else
      @friends = UserInfo.available.opposite_sex(current_user_info[:sex]).match(current_user_info.dest_city).current_sign_in_desc.paginate(page: page, per_page: per_page)
      @local_count = UserInfo.available.opposite_sex(current_user_info[:sex]).local(current_user_info.dest_city).count
      @all_count = @friends.count
      @foreign_count = @all_count - @local_count
    end
    @all_count = @friends.count
    respond_with(@friends) do |format|
      format.json { render :index }
    end
  end

  def local_local
    
  end

  def show
    respond_with(@friend)
  end

  def info
    respond_with(@friend) do |format|
      format.json { render :show }
    end
  end

  def follow
    if current_user.can_followed?
      current_user.follow! @friend
      respond_with(@friend) do |format|
        format.json { render :show }
      end
    else
      render json: { errors: "今天查看的权限已经达到上限#{current_user.today_follow_count}次，谢谢！" }, status: 422
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
    followers = current_user.followers.paginate(page: page, per_page: per_page)
    @total_pages = followers.total_pages
    @current_page = followers.current_page
    @all_count = followers.count
    @friends = followers
    respond_with @friends, template: "friends/vote_index"
  end

  def followings
    page = params[:page] || 1
    per_page = params[:per_page] || 10
    followings = current_user.followings.paginate(page: page, per_page: per_page)
    @total_pages = followings.total_pages
    @current_page = followings.current_page
    @all_count = followings.count
    @friends = followings
    current_user.get_user_count.update_attributes(follow_index: followings.try(:first).try(:id)) if page.to_i == 1
    respond_with @friends, template: "friends/vote_index"
  end

  def collected
    page = params[:page] || 1
    per_page = params[:per_page] || 10
    collections = current_user.collections.paginate(page: page, per_page: per_page)
    @total_pages = collections.total_pages
    @current_page = collections.current_page
    @all_count = collections.count
    @friends = collections
    respond_with @friends, template: "friends/vote_index"
  end

  def like
    current_user.like! @friend
    respond_with(@friend) do |format|
      format.json { render :show }
    end
  end

  def liked
    page = params[:page] || 1
    per_page = params[:per_page] || 10
    likes = current_user.likes.paginate(page: page, per_page: per_page)
    @total_pages = likes.total_pages
    @current_page = likes.current_page
    @all_count = likes.count
    @friends = likes
    current_user.get_user_count.update_attributes(like_index: likes.try(:first).try(:id)) if page.to_i == 1
    respond_with @friends, template: "friends/vote_index"
  end

  def responders
    page = params[:page] || 1
    per_page = params[:per_page] || 10
    responders = current_user.responders.paginate(page: page, per_page: per_page)
    @total_pages = responders.total_pages
    @current_page = responders.current_page
    @all_count = responders.count
    @friends = responders
    # current_user.get_user_count.update_attributes(respond_index: responders.try(:first).try(:id))
    respond_with @friends, template: "friends/vote_index"
  end

  def invite_responds
    page = params[:page] || 1
    per_page = params[:per_page] || 10
    @invite_responds = current_user.invite_responds.paginate(page: page, per_page: per_page)
    @total_pages = @invite_responds.total_pages
    @current_page = @invite_responds.current_page
    @all_count = @invite_responds.count
    current_user.get_user_count.update_attributes(respond_index: @invite_responds.try(:first).try(:id)) if page.to_i ==1
    respond_with @invite_responds
  end

  def count
    @like_count = current_user.like_count
    @follow_count = current_user.follow_count
    @respond_count = current_user.respond_count
    @message_count = Message.count
    @new_like = current_user.get_user_count.try(:new_like?)
    @new_follow = current_user.get_user_count.try(:new_follow?)
    @new_respond = current_user.get_user_count.try(:new_respond?)
    @new_message = current_user.get_user_count.try(:new_message?)
    @new_discover = current_user.get_user_count.try(:new_discover?)
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
