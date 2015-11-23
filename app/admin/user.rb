ActiveAdmin.register User do

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

  permit_params :ban

  index do
    selectable_column
    id_column
    column :phone
    column :avatar do |obj|
      link_to(image_tag(obj.user_info.avatar.url(:mini)), obj.user_info.avatar.url) if obj.try(:user_info).try(:avatar)
    end
    column :sex
    column :age
    column :ban
    column :city do |user|
      "#{user.province}-#{user.city}"
    end
    column :dest_city do |user|
      "#{user.dest_province}-#{user.dest_city}"
    end
    column :contact do |user|
      "#{user.contact_type}-#{user.contact}"
    end
    column :complain_count
    column :last_sign_in_at
    column :sign_in_count
    column :constellation
    actions
  end

  form do |f|
    inputs 'Details' do
      input :ban
    end
    actions
  end


end
