# == Schema Information
#
# Table name: messages
#
#  id         :integer          not null, primary key
#  content    :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class MessagesController < ApplicationController

  acts_as_token_authentication_handler_for User

  before_action :set_message, only: [:show, :edit, :update, :destroy]

  respond_to :html, :json

  def index
    @messages = Message.all
    current_user.get_user_count.update_attributes(message_index: @messages.try(:first).try(:id))

    respond_with(@messages)
  end

  def show
    respond_with(@message)
  end

  def new
    @message = Message.new
    respond_with(@message)
  end

  def edit
  end

  def create
    @message = Message.new(message_params)
    @message.save
    respond_with(@message)
  end

  def update
    @message.update(message_params)
    respond_with(@message)
  end

  def destroy
    @message.destroy
    respond_with(@message)
  end

  private
    def set_message
      @message = Message.find(params[:id])
    end

    def message_params
      params[:message]
    end
end
