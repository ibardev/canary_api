json.user_info_id current_user.try(:user_info).try(:id)

json.pictures!(@pictures) do |picture|
  json.extract! picture, :id
  json.photo photo_url(picture, :product)
end
