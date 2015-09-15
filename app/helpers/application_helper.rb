module ApplicationHelper

  def photo_url image, mode
    image.present? ? image_url(image.photo.url(mode)) : ""
  end
  
end
