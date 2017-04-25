class Book < ApplicationRecord
  validates :title, :price, :description, :category_id, presence: true

  has_and_belongs_to_many :authors
  has_and_belongs_to_many :materials
  has_many :order_items
  belongs_to :category
  has_many :pictures
  has_many :reviews, -> { where(published: true ).order(updated_at: :desc) }
  accepts_nested_attributes_for :pictures, allow_destroy: true

  def self.bestsellers(items)
    includes(:pictures, :authors).joins(:order_items).group(:id).select('books.*, sum(order_items.quantity) as quantity').order('quantity desc').first(items)
  end

  def self.latest_books(items)
    includes(:pictures, :authors).order(created_at: :desc).limit(items)
  end

  def self.with_category_filter(category)
    case category
    when 'photo'
      self.joins(:category).where("categories.name = 'Photo'")
    when 'web_design'
      self.joins(:category).where("categories.name = 'Web design'")
    when 'web_development'
      self.joins(:category).where("categories.name = 'Web development'")
    else
      self.joins(:category).where("categories.name = 'Mobile development'")
    end
  end

  def self.with_filter(filter)
    case filter
    when 'newest_first'
      self.order(created_at: :desc)
    when 'popular_first'
      joins(:order_items).group(:id).select('books.*, sum(order_items.quantity) as quantity').order('quantity desc')
    when 'price_low_to_hight'
      self.order(price: :asc)
    when 'price_hight_to_low'
      self.order(price: :desc)
    when 'title_z_a'
      self.order(title: :desc)
    else self.order(title: :asc)
    end
  end
end
