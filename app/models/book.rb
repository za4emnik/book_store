class Book < ApplicationRecord
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
    case category
    when 'photo'
      joins(:category).where("categories.name = 'Photo'")
    when 'web_design'
      joins(:category).where("categories.name = 'Web design'")
    when 'web_development'
      joins(:category).where("categories.name = 'Web development'")
    else
      joins(:category).where("categories.name = 'Mobile development'")
    end
  end

  def self.with_filter(filter)
    case filter
    when 'newest_first'
      order(created_at: :desc)
    when 'popular_first'
      quantity_items = BooksQuery.new(joins(:order_items)).sum_items_quantity
      quantity_items.order('quantity desc')
    when 'price_low_to_hight'
      order(price: :asc)
    when 'price_hight_to_low'
      order(price: :desc)
    when 'title_z_a'
      order(title: :desc)
    else order(title: :asc)
    end
  end
end
