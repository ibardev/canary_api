json.banners(@banners) do |banner|
  json.extract! banner, :id, :title, :url, :created_at, :updated_at
  json.cover_image photo_url(banner.cover_image, :medium)
end
