require 'rails_helper'
require 'rspec_api_documentation'
require 'rspec_api_documentation/dsl'

RspecApiDocumentation.configure do |config|
  config.format = [:html]
  config.curl_host = 'http://139.196.18.247/'
  config.api_name = "Canary App API"
  # Change how the post body is formatted by default, you can still override by `raw_post`
  # Can be :json, :xml, or a proc that will be passed the params
  config.post_body_formatter = Proc.new { |params| params }
end