class PicturesController < ApplicationController
  acts_as_token_authentication_handler_for User

  before_action :set_picture, only: [:show, :edit, :update, :destroy]

  respond_to :html, :json

  def index
    user_info = params[:id].present? ? UserInfo.find(params[:id]) : current_user_info
    @pictures = user_info.pictures
    respond_with(@pictures)
  end

  def show
    respond_with(@picture)
  end

  def new
    @picture = Picture.new
    respond_with(@picture)
  end

  def edit
  end

  def create
    current_user_info.pictures.destroy_all
    current_user_info.update(picture_params)
    current_user_info.save
    @pictures = current_user_info.pictures
    respond_with(@pictures) do |format|
      format.json { render :index, status: 201 }
    end
  end

  def update
    @picture.update(picture_params)
    respond_with(@picture)
  end

  def destroy
    @picture.destroy
    respond_with(@picture)
  end

  private
    def set_picture
      @picture = current_user_info.pictures.find(params[:id])
    end

    def picture_params
      params.permit(
        pictures_attributes: [:id, :photo, :_destroy]
        )
    end
end
