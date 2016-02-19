json.extract! @invite_discover, :user_id, :begin_date, :end_date, :content, :updated_at
json.respond_count @invite_discover.respond_count

if @invite_discover.user
  user_info = @invite_discover.user.user_info
  json.extract! user_info, :nickname, :carreer, :age, :constellation, :sex, :hotel_type
  json.avatar user_info.avatar.present? ? user_info.avatar.url(:medium) : ""

  json.collected current_user.collected?(user_info)
  json.local current_user.same_city? user_info
  json.is_respond @invite_discover.respond?(current_user.user_info)
  json.respond_count @invite_discover.respond_count
end

json.images @invite_discover.images do |image|
  json.small photo_url(image, :small)
  json.big photo_url(image, :product)
end