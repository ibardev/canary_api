json.array!(@discovers) do |discover|

  if discover.user
    user_info = discover.user.user_info
    json.user_info_id user_info.try(:id)
    json.extract! user_info, :nickname, :carreer, :age, :constellation, :sex, :hotel_type, :slogan
    json.avatar user_info.avatar.present? ? user_info.avatar.url(:medium) : ""

    json.collected current_user.collected?(user_info)
    json.local current_user.same_city? user_info
    json.respond_count discover.discoverable.respond_count if discover.discoverable.respond_to?(:respond_count)
    json.is_respond discover.discoverable.respond?(current_user.user_info) if discover.discoverable.respond_to?(:respond?)
  end

  json.extract! discover, :id, :discoverable_type, :discoverable_id, :updated_at

  json.detail discover.discoverable.as_json
  json.share_url invite_discover_url(discover.discoverable) if discover.discoverable_type == 'InviteDiscover'


end
