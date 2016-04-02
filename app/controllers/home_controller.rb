class HomeController < ApplicationController
  def index
    user_agent = request.env['HTTP_USER_AGENT'].downcase 
    @is_safari = user_agent.include? "safari"
  end
end
