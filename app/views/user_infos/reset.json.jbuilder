if @user.errors.present?
  json.error @user.errors.full_messages.first
else
  json.extract! @user, :authentication_token, :phone, :id
end