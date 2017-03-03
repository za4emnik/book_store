ActiveAdmin.register Book do
  permit_params :title, :price, :category_id, :description, author_ids: [], pictures_attributes: [:id, :_destroy, :image]

  form html: { multipart: true } do |f|
    semantic_errors

    inputs do
      input :title
      input :author_ids, as: :tags, collection: Author.all, display_name: :full_name
      input :category_id, as: :select, collection: Category.all
      input :price
    end

    inputs do
      has_many :pictures, allow_destroy: true do |p|
        p.input :image, as: :file, hint: p.object.image.url ? image_tag(p.object.image.url(:thumb)) : ''
      end
    end
    actions
  end
end
