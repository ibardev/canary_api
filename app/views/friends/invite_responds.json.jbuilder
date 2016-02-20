json.total_pages @total_pages || @invite_responds.total_pages
json.current_page @current_page || @invite_responds.current_page
json.all_count @all_count || @invite_responds.count

json.invite_responds(@invite_responds) do |invite_respond|
  friend = invite_respond.voter
  invite_discover = invite_respond.votable
  json.created_at invite_respond.created_at
  json.extract! friend, :id, :sex, :nickname, :slogan, :age, :constellation, :hotel_type, :carreer
  json.avatar friend.avatar.present? ? friend.avatar.url(:medium) : ""
  json.avatar_origin friend.avatar.present? ? friend.avatar.url(:original) : ""
  json.collected current_user.collected?(friend)
  json.local current_user.same_city? friend, @local
  json.followed current_user.followed?(friend)
  json.content invite_discover.content
end
