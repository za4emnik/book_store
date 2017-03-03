class Picture < ApplicationRecord
  belongs_to :book
  mount_uploader :image, BookCoverUploader
end
