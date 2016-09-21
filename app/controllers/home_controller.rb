class HomeController < ApplicationController

  wechat_api

  def index

    connection = Faraday::Connection.new "http://wechat-api.tallty.com"
    response = connection.get '/lvke_wechat/js_hash.json', { page_url: "http://www.lvkeapp.com" }
    logger.info "response is:#{MultiJson.load response.body}"

    @js_hash = MultiJson.load response.body


    user_agent = request.env['HTTP_USER_AGENT'].downcase 

    # if user_agent.include?("iphone") || user_agent.include?("android")
    @is_safari = user_agent.include? "safari"
  end
end
