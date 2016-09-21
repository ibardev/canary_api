class HomeController < ApplicationController
  
  wechat_api

  def index
    user_agent = request.env['HTTP_USER_AGENT'].downcase 
    # if user_agent.include?("iphone") || user_agent.include?("android")
    @is_safari = user_agent.include? "safari"
  end
end
