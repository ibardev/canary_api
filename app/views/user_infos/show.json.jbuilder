json.extract! @user_info, :id, :sex, :nickname, :birth, :age, :constellation, :dest_province, :dest_city, 
  :province, :city, :contact_type, :contact, :slogan, :carreer, :flight, :train,
  :created_at, :updated_at
json.avatar @user_info.avatar.present? ? @user_info.avatar.url(:medium) : ""
