json.extract! @friend, :id, :sex, :nickname, :birth, :age, :constellation, :dest_province, :dest_city, 
  :province, :city, :slogan, :train, :flight, :hotel_type, :carreer,
  :created_at, :updated_at
json.avatar @friend.avatar.present? ? @friend.avatar.url(:medium) : ""
json.collected current_user.collected?(@friend)
json.local current_user.same_city? @friend

json.followed current_user.followed?(@friend)
if current_user.followed? @friend
  json.contact_type @friend.contact_type
  json.contact @friend.contact
end
