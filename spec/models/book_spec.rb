require 'rails_helper'

RSpec.describe Book, type: :model do
  context 'associations' do
    it { should have_and_belong_to_many(:authors) }
    it { should have_and_belong_to_many(:materials) }
    it { should have_many(:order_items) }
    it { should have_many(:pictures) }
    it { should have_many(:reviews) }
    it { should belong_to(:category) }
    it { should accept_nested_attributes_for(:pictures) }
  end

  context 'validations' do
    %i[title price description category_id].each do |field|
      it { should validate_presence_of(field) }
    end
  end

  context '#bestsellers' do
    before do
      FactoryGirl.create_list(:book, 5)
    end

    it 'should return no more than 4 books' do
      expect(Book.latest_books(4).length).to be <= 4
    end
  end

  context '#with_category_filter' do
    %w[photo web_design web_development].each do |category|
      it "should return books in #{category} category" do
        allow(Book).to receive(:joins).and_return Book
        expect(Book).to receive(:where).with("categories.name = '#{category.humanize}'")
        Book.with_category_filter(category)
      end
    end

    it 'shoud return books in mobile development category by default' do
      allow(Book).to receive(:joins).and_return Book
      expect(Book).to receive(:where).with('categories.name = \'Mobile development\'')
      Book.with_category_filter('mobile_development')
    end
  end

  context '#latest_books' do
    before do
      FactoryGirl.create_list(:book, 5)
    end

    it 'should return no more than 3 books' do
      expect(Book.latest_books(3).length).to be <= 3
    end

    it 'should sort descending' do
      books = Book.order(created_at: :desc).limit(100)
      expect(Book.latest_books(100)).to eq(books)
    end
  end

  context '#with_filter' do
    before do
      FactoryGirl.create_list(:book, 5)
    end

    it 'should sort descending' do
      books = Book.order(created_at: :desc)
      expect(Book.with_filter('newest_first')).to eq(books)
    end

    it 'should sort ascending price' do
      books = Book.order(price: :asc)
      expect(Book.with_filter('price_low_to_hight')).to eq(books)
    end

    it 'should sort descending price' do
      books = Book.order(price: :desc)
      expect(Book.with_filter('price_hight_to_low')).to eq(books)
    end

    it 'should sort title Z - A' do
      books = Book.order(title: :desc)
      expect(Book.with_filter('title_z_a')).to eq(books)
    end

    it 'should sort descending by default' do
      books = Book.order(title: :asc)
      expect(Book.with_filter('title_a_z')).to eq(books)
    end
  end
end
