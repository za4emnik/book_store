ActiveAdmin.register Book do
  permit_params :title, :price, :category_id, :description, author_ids: [], pictures_attributes: [:id, :_destroy, :image]

  index do
    selectable_column
    column 'Image' do |book|
       image_tag book.pictures.first.image.url(:thumb)
    end
    column :category
    column :title
    column 'Authors' do |book|
      book.authors.map(&:full_name).join(", ").html_safe
    end
    column 'Short description' do |book|
      book.description.truncate(50)
    end
    column :price
    actions
  end

  show do
    attributes_table do
      row :id
      row :title
      row 'Authors' do
        book.authors.map(&:full_name).join(", ").html_safe
      end
      row :category
      row :price
      row :description
      row 'Image' do
         image_tag book.pictures.first.image.url(:thumb)
      end
    end
  end

  form html: { multipart: true } do |f|
    semantic_errors

    inputs do
      input :title
      input :author_ids, as: :tags, collection: Author.all, display_name: :full_name
      input :category_id, as: :select, collection: Category.all
      input :price
      input :description, as: :pagedown_text
    end

    inputs do
      has_many :pictures, allow_destroy: true do |p|
        p.input :image, as: :file, hint: p.object.image.url ? image_tag(p.object.image.url(:thumb)) : ''
      end
    end
    actions
  end

end
