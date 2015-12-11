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

  permit_params :ban, :phone, :sms_token, :password, :password_confirmation, 
              user_info_attributes: 
              [:nickname, :sex, :province, :city, :dest_province, :dest_city,
                :slogan, :birth, :contact_type, :contact  ]

  filter :phone
  filter :ban
  filter :user_info_sex, as: :select, collection: UserInfo.sexes, label: 'sex'
  filter :user_info_province, as: :string, label: 'province'
  filter :user_info_city, as: :string, label: 'city'
  filter :user_info_dest_province, as: :string, label: 'dest province'
  filter :user_info_dest_city, as: :string, label: 'dest city'
  filter :user_info_contact_type, as: :select, collection: UserInfo.contact_types, label: 'contact type'
  filter :user_info_contact, as: :string, label: 'contact'

  member_action :ban, method: :post do
    resource.ban!
    redirect_to collection_path, notice: "Ban user success!"
  end

  member_action :unban, method: :post do
    resource.unban!
    redirect_to collection_path, notice: "Unban user success!"
  end

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
    column "Ban Action" do |user|
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
    if f.object.new_record?
      f.inputs "User Account" do
        f.input :sms_token
        f.input :phone
        f.input :password
      end
    end
    
    f.inputs "User Info", for: [:user_info, f.object.user_info || f.object.build_user_info] do |cf|
      cf.input :nickname
      cf.input :sex, as: :select, collection: UserInfo.sexes.keys
      cf.input :province
      cf.input :city
      cf.input :dest_province
      cf.input :dest_city
      cf.input :birth
      cf.input :slogan
      cf.input :contact_type, as: :select, collection: UserInfo.contact_types.keys
      cf.input :contact
    end
    actions
  end


end
