class DiscoversController < ApplicationController
  before_action :set_discover, only: [:show, :edit, :update, :destroy]

  respond_to :html, :json

  def index
    @discovers = Discover.all
    respond_with(@discovers)
  end

  def show
    respond_with(@discover)
  end

  def new
    @discover = Discover.new
    respond_with(@discover)
  end

  def edit
  end

  def create
    @discover = Discover.new(discover_params)
    @discover.save
    respond_with(@discover)
  end

  def update
    @discover.update(discover_params)
    respond_with(@discover)
  end

  def destroy
    @discover.destroy
    respond_with(@discover)
  end

  private
    def set_discover
      @discover = Discover.find(params[:id])
    end

    def discover_params
      params[:discover]
    end
end
