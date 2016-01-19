# == Schema Information
#
# Table name: discovers
#
#  id                :integer          not null, primary key
#  discoverable_id   :integer
#  discoverable_type :string
#  user_id           :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  block             :boolean
#
# Indexes
#
#  index_discovers_on_block                                  (block)
#  index_discovers_on_discoverable_type_and_discoverable_id  (discoverable_type,discoverable_id)
#  index_discovers_on_user_id                                (user_id)
#

class DiscoversController < ApplicationController
  acts_as_token_authentication_handler_for User

  before_action :set_discover, only: [:show, :edit, :update, :destroy]

  respond_to :html, :json

  def index
    page = params[:page] || 1
    per_page = params[:per_page] || 10
    @discovers = Discover.unblock.available.paginate(page: page, per_page: per_page)
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
