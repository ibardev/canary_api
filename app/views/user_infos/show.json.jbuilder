json.extract! @user_info, :id, :sex, :nickname, :birth, :age, :constellation, :dest_province, :dest_city, 
  :province, :city, :contact_type, :contact, :slogan, :carreer, :flight, :train,
  :hotel_type, :created_at, :updated_at
json.avatar @user_info.avatar.present? ? @user_info.avatar.url(:medium) : ""
json.avatar_origin @user_info.avatar.present? ? @user_info.avatar.url(:original) : ""
json.collected current_user.collected?(@user_info)

json.cover_image photo_url(@user_info.cover_image, :product)
json.cover_image_origin photo_url(@user_info.cover_image, :original)

json.like_count current_user.like_count
json.follow_count current_user.follow_count
json.respond_count current_user.respond_count


