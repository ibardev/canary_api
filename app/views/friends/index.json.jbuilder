json.array!(@friends) do |friend|
  json.extract! friend, :id, :sex, :nickname, :slogan, :age, :constellation, :local, :collected, :hotel_type, :carreer
  json.avatar friend.avatar.present? ? friend.avatar.url(:medium) : ""
end
