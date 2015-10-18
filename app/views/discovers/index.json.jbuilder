json.array!(@discovers) do |discover|

  if discover.user
    user_info = discover.user.user_info
    json.user_info_id user_info.try(:id)
    json.extract! user_info, :nickname, :carreer, :age, :constellation
    json.avatar user_info.avatar.present? ? user_info.avatar.url(:medium) : ""

    json.collected current_user.collected?(user_info)
    json.local current_user.same_city? user_info
  end

  json.extract! discover, :id, :discoverable_type, :discoverable_id, :updated_at

  json.detail discover.discoverable.as_json


end
