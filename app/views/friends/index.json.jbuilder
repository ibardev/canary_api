json.array!(@friends) do |friend|
  json.extract! friend, :id, :sex, :nickname, :slogan, :age, :constellation, :local, :hotel_type, :carreer
  json.avatar friend.avatar.present? ? friend.avatar.url(:medium) : ""
  json.collected current_user.collected?(friend)
end
