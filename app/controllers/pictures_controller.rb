class PicturesController < ApplicationController
  acts_as_token_authentication_handler_for User

  before_action :set_picture, only: [:show, :edit, :update, :destroy]

  respond_to :html, :json

  def index
    user_info = params[:friend_id].present? ? UserInfo.find(params[:friend_id]) : current_user_info
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

  def append
    current_user_info.pictures.build picture_params[:pictures_attributes]
    current_user_info.save
    @pictures = current_user_info.pictures
    respond_with(@pictures, template: "pictures/index", status: 201)
  end

  def create
    current_user_info.update(picture_params)
    current_user_info.save
    @pictures = current_user_info.pictures
    respond_with(@pictures, template: "pictures/index", status: 201)
  end

  def delete
    delete_params[:ids].each do |id|
      current_user_info.pictures.find(id).destroy rescue next
    end
    @pictures = current_user_info.pictures
    respond_with(@pictures, template: "pictures/index", status: 201)
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
        pictures_attributes: [:id, :photo, :photo_type, :_destroy]
        )
    end

    def delete_params
      params.require(:pictures).permit(ids:[])
    end
end
