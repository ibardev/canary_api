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

  filter :phone
  filter :ban
  filter :user_info_sex, as: :select, collection: UserInfo.sexes, label: 'sex'
  filter :user_info_province, as: :string, label: 'province'
  filter :user_info_city, as: :string, label: 'city'
  filter :user_info_dest_province, as: :string, label: 'dest province'
  filter :user_info_dest_city, as: :string, label: 'dest city'
  filter :user_info_contact_type, label: 'contact type'
  filter :user_info_contact, as: :string, label: 'contact'

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
