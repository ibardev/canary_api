ActiveAdmin.register UserInfo do

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

  permit_params :nickname, :sex, :province, :city, :dest_province, :dest_city, :oversea,
                :slogan, :birth, :contact_type, :contact, :avatar

  filter :phone
  filter :ban
  filter :sex, as: :select, collection: UserInfo.sexes, label: 'sex'
  filter :nickname, as: :string, label: 'nickname'
  filter :province, as: :string, label: 'province'
  filter :city, as: :string, label: 'city'
  filter :dest_province, as: :string, label: 'dest province'
  filter :dest_city, as: :string, label: 'dest city'
  filter :contact_type, as: :select, collection: UserInfo.contact_types, label: 'contact type'
  filter :contact, as: :string, label: 'contact'

  index do
    selectable_column
    id_column
    column :user_id do |obj|
      obj.user_id
    end
    column :phone
    column :nickname
    column :avatar do |obj|
      link_to(image_tag(obj.avatar.url(:mini)), obj.avatar.url) if obj.try(:avatar)
    end
    column :sex
    column :age
    column :ban
    column "Ban Action" do |user_info|
      user = user_info.user
      if user.banned?
        link_to "取消封禁", unban_admin_user_path(user), method: :post
      else
        link_to "封禁用户", ban_admin_user_path(user), method: :post
      end
    end
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
    user_info = f.object
    f.inputs "User Info" do
      f.input :nickname
      f.input :avatar, as: :file, hint: (user_info.avatar.blank?) \
        ? f.content_tag(:span, "no cover page yet")
        : f.link_to(image_tag(user_info.avatar.url(:medium)), user_info.avatar.url, target: "_blank")

      f.input :sex, as: :select, collection: UserInfo.sexes.keys
      f.input :province
      f.input :city
      f.input :dest_province
      f.input :dest_city
      f.input :birth
      f.input :contact_type, as: :select, collection: UserInfo.contact_types.keys
      f.input :contact
      f.input :slogan
    end
    actions
  end

  show do |obj|
    attributes_table do
      row :phone
      row :avatar do
        if obj.avatar
          link_to(image_tag(obj.avatar.url(:medium)), obj.avatar.url, target: "_blank")
        end
      end
      row :sex
      row :ban
      row :nickname
      row :province
      row :city
      row :dest_province
      row :dest_city
      row :age
      row :sex
      row :constellation
    end
  end

end
