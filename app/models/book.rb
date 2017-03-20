class Book < ApplicationRecord
  validates :title, :price, :description, :category_id, presence: true

  has_and_belongs_to_many :authors
  has_and_belongs_to_many :materials
  has_many :order_items
  belongs_to :category
  has_many :pictures
  has_many :reviews, -> { where(published: true ).order(updated_at: :desc) }
  accepts_nested_attributes_for :pictures, allow_destroy: true

  def self.bestsellers(number)
    joins(:order_items).group(:id).select('books.*, sum(order_items.quantity) as quantity').order('quantity desc').first(number)
  end

  def self.latest_books
    order(created_at: :desc).limit(5)
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
    else self.order(updated_at: :desc)
    end
  end
end
