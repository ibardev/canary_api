json.array!(@wechat_sessions) do |wechat_session|
  json.extract! wechat_session, :id
  json.url wechat_session_url(wechat_session, format: :json)
end
