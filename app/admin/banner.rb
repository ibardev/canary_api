ActiveAdmin.register Banner do

# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
# permit_params :list, :of, :attributes, :on, :model
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if resource.something?
#   permitted
# end

  permit_params :title, :url, :position,
    cover_image_attributes: [:id, :photo, :_destroy]

  config.sort_order = 'position_asc' # assumes you are using 'position' for your acts_as_list column

  sortable # creates the controller action which handles the sorting

  index do
    selectable_column
    sortable_handle_column
    column :title
    column :url
    column :cover_image do |obj|
      link_to(image_tag(obj.cover_image.photo.url(:mini)), obj.cover_image.photo.url) if obj.cover_image
    end
    actions
  end

  form html: {multipart: true} do |f|
    f.inputs "Admin Details" do
      f.input :title
      f.input :url

      f.fields_for :cover_image, for: [:cover_image, f.object.cover_image || f.object.build_cover_image] do |cf|
        cover_image = cf.object
        cf.input :photo, as: :file, hint: (cover_image.photo.blank?) \
          ? cf.template.content_tag(:span, "no cover page yet")
          : cf.template.link_to(image_tag(cover_image.photo.url(:medium)), cover_image.photo.url, target: "_blank")
      end
    end
    f.actions
  end


end
