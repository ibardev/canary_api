require "application_responder"
require 'will_paginate/array'

class ApplicationController < ActionController::Base
  self.responder = ApplicationResponder
  respond_to :html, :json

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # protect_from_forgery with: :exception
  protect_from_forgery with: :null_session

  before_action :configure_permitted_parameters, if: :devise_controller?

  def current_user_info
    current_user.try(:user_info)
  end

  helper_method :current_customer, :current_merchant

  protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.for(:sign_up).concat [:sms_token]
    end
end
