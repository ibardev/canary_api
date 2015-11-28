ActiveAdmin.register InviteDiscover do

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
  member_action :block, method: :post do
    resource.block!
    redirect_to collection_path, notice: "Blocked!"
  end

  member_action :unblock, method: :post do
    resource.unblock!
    redirect_to collection_path, notice: "Unblocked!"
  end

  index do
    selectable_column
    column :images do |obj|
      obj.images.each do |image|
        link_to(image_tag(image.photo.url(:mini)), image.photo.url) if image.photo
      end
    end
    column :id
    column :user
    column :begin_date
    column :end_date
    column :content
    column :block

    column "Block Action" do |discover|
      if discover.block
        link_to "取消屏蔽", unblock_admin_invite_discover_path(discover), method: :post
      else
        link_to "屏蔽邀约", block_admin_invite_discover_path(discover), method: :post
      end
    end
    actions
  end

end
