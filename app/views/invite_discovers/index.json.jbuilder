json.array!(@invite_discovers) do |invite_discover|
  json.extract! invite_discover, :id
  json.url invite_discover_url(invite_discover, format: :json)
end
