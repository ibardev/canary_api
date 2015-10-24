ActiveAdmin.register UserDiscover do

# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
# permit_params :list, :of, :attributes, :on, :model
#
# or
#
  permit_params do
    permitted = [:permitted, :attributes]
    permitted << :other if resource.something?
    permitted
  end

  permit_params :user_id

  index do
    selectable_column
    id_column
    column :user_id do |discover|
      discover.user.try(:id)
    end
    column :phone do |discover|
      discover.user.try(:phone)
    end
    column :nickname do |discover|
      discover.user.try(:nickname)
    end
    column :updated_at
    actions
  end

  form do |f|
    inputs 'Details' do
      input :user
    end
    actions
  end


end
