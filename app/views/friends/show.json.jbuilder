json.extract! @friend, :id, :sex, :nickname, :birth, :age, :constellation, :dest_province, :dest_city, 
  :province, :city, :contact_type, :contact, :slogan,
  :created_at, :updated_at
json.avatar @friend.avatar.present? ? @friend.avatar.url(:medium) : ""
json.followed true
