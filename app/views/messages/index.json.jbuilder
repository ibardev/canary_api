

json.messages(@messages) do |message|
  json.extract! message, :id, :content, :created_at
end
