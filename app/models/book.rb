class Book < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :slugged

  validates :title, :price, :description, :category_id, presence: true
  default_scope -> { preload(:authors, :pictures) }

  has_and_belongs_to_many :authors
  has_and_belongs_to_many :materials
  has_many :order_items
  has_many :pictures, dependent: :destroy
  has_many :reviews, -> { where(aasm_state: 'approved').order(updated_at: :desc) }
  belongs_to :category
  accepts_nested_attributes_for :pictures, allow_destroy: true

  def create_associated_image(image)
    pictures.create(image: image)
  end

  def self.bestsellers(items)
    with_models = BooksQuery.new.with_associate_models
    items_quantity = BooksQuery.new(with_models).sum_items_quantity
    items_quantity.order('quantity desc').first(items)
  end

  def self.latest_books(items)
    includes(:pictures, :authors).order(created_at: :desc).limit(items)
  end

  def self.with_category_filter(category)
    category = category&.humanize || 'Mobile development'
    joins(:category).where("categories.name = '#{category}'")
  end

  def self.with_filter(filter)
    BooksQuery.new.with_filter(filter)
  end
end
