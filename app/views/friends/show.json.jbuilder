json.extract! @friend, :id, :sex, :nickname, :birth, :age, :constellation, :dest_province, :dest_city, 
  :province, :city, :slogan, :train, :flight, :hotel_type, :carreer,
  :created_at, :updated_at
json.oversea @friend.oversea || false
json.avatar @friend.avatar.present? ? @friend.avatar.url(:medium) : ""
json.avatar_origin @friend.avatar.present? ? @friend.avatar.url(:original) : ""
json.collected current_user.collected?(@friend)
json.local current_user.same_city? @friend
json.cover_image photo_url(@friend.cover_image, :product)
json.cover_image_origin photo_url(@friend.cover_image, :original)
json.today_follow_count current_user.today_follow_count
json.like_count @friend.try(:user).try(:like_count)

json.followed current_user.followed?(@friend)
if current_user.followed? @friend
  json.contact_type @friend.contact_type
  json.contact @friend.contact
end