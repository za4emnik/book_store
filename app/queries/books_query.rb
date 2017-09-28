class BooksQuery
  attr_reader :relation

  def initialize(relation = Book.all)
    @relation = relation
  end

  def sum_items_quantity
    relation.group(:id).select('books.*, sum(order_items.quantity) as quantity')
  end

  def with_associate_models
    relation.includes(:pictures, :authors).joins(:order_items)
  end
end
