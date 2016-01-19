# == Schema Information
#
# Table name: sms_tokens
#
#  id         :integer          not null, primary key
#  phone      :string
#  token      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_sms_tokens_on_phone  (phone)
#

class SmsTokensController < ApplicationController
  respond_to :html, :json

  def register
    @sms_token = SmsToken.register sms_token_params[:phone]
    respond_with(@sms_token)
  end

  def show
    @sms_token = SmsToken.find_by params[:id]
  end

  private

    def sms_token_params
      params.require(:sms_token).permit(:phone)
    end
end
