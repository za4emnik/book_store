ActiveAdmin.register Category do
  config.batch_actions = true
  permit_params :name

  index do
    selectable_column
    column :id
    column :name
    actions
  end

  actions :all

  batch_action :destroy do |ids|
    redirect_to collection_path, alert: "Didn't really delete these!"
  end
end
