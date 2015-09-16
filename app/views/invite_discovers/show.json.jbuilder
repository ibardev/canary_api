json.extract! @invite_discover, :user_id, :begin_date, :end_date, :content, :updated_at

if @invite_discover.user
  user_info = @invite_discover.user.user_info
  json.extract! user_info, :nickname, :carreer
  json.avatar user_info.avatar.present? ? user_info.avatar.url(:medium) : ""
end

json.small_images @invite_discover.images do |image|
  json.image_url photo_url(image, :small)
end

json.big_images @invite_discover.images do |image|
  json.image_url photo_url(image, :big)
end