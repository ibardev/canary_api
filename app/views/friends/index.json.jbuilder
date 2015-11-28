json.array!(@friends) do |friend|
  json.extract! friend, :id, :sex, :nickname, :slogan, :age, :constellation, :hotel_type, :carreer
  json.avatar friend.avatar.present? ? friend.avatar.url(:medium) : ""
  json.avatar_origin friend.avatar.present? ? friend.avatar.url(:original) : ""
  json.collected current_user.collected?(friend)
  json.local current_user.same_city? friend, @local
  json.followed current_user.followed?(friend)
end
