require 'rails_helper'

RSpec.describe Book, type: :model do
  let(:author) { create(:author) } # Author factory가 필요합니다.

  describe 'Associations' do
    it { should belong_to(:author) }
    it { should have_many(:order_items) }
    it { should have_many(:orders).through(:order_items) }
  end

  describe 'Validations' do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:author) } # author_id presence_of 또는 association presence
    it { should validate_presence_of(:published_year) }
    it { should validate_presence_of(:isbn) }
    it { should validate_uniqueness_of(:isbn) }
    it { should validate_presence_of(:price) }
    it { should validate_numericality_of(:price).is_greater_than(0) }
    it { should validate_presence_of(:stock_quantity) }
    it { should validate_numericality_of(:stock_quantity).is_greater_than_or_equal_to(0) }

    it 'is valid with valid attributes' do
      book = Book.new(
        title: 'Sample Book',
        author: author,
        published_year: 2023,
        isbn: '978-1234567890',
        price: 19.99,
        stock_quantity: 10
      )
      expect(book).to be_valid
    end

    it 'is not valid without a title' do
      book = Book.new(title: nil, author: author, isbn: 'some-isbn', price: 10.0, stock_quantity: 5)
      expect(book).to_not be_valid
      expect(book.errors[:title]).to include("can't be blank")
    end

    it 'is not valid with a duplicate isbn' do
      create(:book, isbn: '978-1234567891', author: author)
      book = build(:book, isbn: '978-1234567891', author: author)
      expect(book).to_not be_valid
      expect(book.errors[:isbn]).to include("has already been taken")
    end

    it 'is not valid with price less than or equal to 0' do
      book = build(:book, price: 0, author: author)
      expect(book).to_not be_valid
      expect(book.errors[:price]).to include("must be greater than 0")
    end

    it 'is not valid with stock_quantity less than 0' do
      book = build(:book, stock_quantity: -1, author: author)
      expect(book).to_not be_valid
      expect(book.errors[:stock_quantity]).to include("must be greater than or equal to 0")
    end
  end

  describe '#available?' do
    it 'returns true if stock_quantity is greater than 0' do
      book = build(:book, stock_quantity: 1, author: author)
      expect(book.available?).to be true
    end

    it 'returns false if stock_quantity is 0' do
      book = build(:book, stock_quantity: 0, author: author)
      expect(book.available?).to be false
    end
  end
end