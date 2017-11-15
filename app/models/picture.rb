class Picture < ApplicationRecord
  validates :image, :book_id, presence: true

  belongs_to :book

  mount_uploader :image, BookCoverUploader
end
