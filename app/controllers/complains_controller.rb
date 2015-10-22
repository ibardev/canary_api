class ComplainsController < ApplicationController
  before_action :set_complain, only: [:show, :edit, :update, :destroy]

  acts_as_token_authentication_handler_for User
  
  respond_to :html, :json

  def index
    @complains = Complain.all
    respond_with(@complains)
  end

  def show
    respond_with(@complain)
  end

  def new
    @complain = Complain.new
    respond_with(@complain)
  end

  def edit
  end

  def create
    @source_compainer = UserInfo.find_by(params[:friend_id])
    @dest_compainer = current_user_info

    @complain = Complain.new(complain_params)
    @complain.source_compainer = @source_compainer
    @complain.dest_compainer = @dest_compainer
    @complain.save
    respond_with(@complain)
  end

  def update
    @complain.update(complain_params)
    respond_with(@complain)
  end

  def destroy
    @complain.destroy
    respond_with(@complain)
  end

  private
    def set_complain
      @complain = Complain.find(params[:id])
    end

    def complain_params
      params.require(:complain).permit(
        :reason, :comment
        )
    end
end
