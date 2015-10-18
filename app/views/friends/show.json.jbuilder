json.extract! @friend, :id, :sex, :nickname, :birth, :age, :constellation, :dest_province, :dest_city, 
  :province, :city, :slogan, :local, :train, :flight, :hotel_type, :carreer,
  :created_at, :updated_at
json.avatar @friend.avatar.present? ? @friend.avatar.url(:medium) : ""
json.followed true
json.collected current_user.collected?(@friend)
json.followed current_user.followed?(@friend)
if current_user.followed? @friend
  json.contact_type @friend.contact_type
  json.contact @friend.contact
end
