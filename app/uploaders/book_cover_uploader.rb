class BookCoverUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  process resize_to_fill: [555, 685]

  def store_dir
    "uploads/books/#{mounted_as}/#{model.id}"
  end

  version :thumb do
    process resize_to_fill: [174, 200]
  end
end
