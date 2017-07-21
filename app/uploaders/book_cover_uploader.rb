class BookCoverUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  storage :file

  def store_dir
    "uploads/books/#{mounted_as}/#{model.id}"
  end

  version :thumb do
    process resize_to_fit: [200, 300]
  end
end
