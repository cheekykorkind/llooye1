require 'rails_helper'

RSpec.describe OrderItem, type: :model do
  let(:author) { create(:author) }
  let(:book) { create(:book, author: author) }
  let(:order) { create(:order) }

  describe 'Associations' do
    it { should belong_to(:order) }
    it { should belong_to(:book) }
  end

  describe 'Validations' do
    it { should validate_presence_of(:quantity) }
    it { should validate_numericality_of(:quantity).is_greater_than_or_equal_to(1) }
    it { should validate_presence_of(:unit_price) }
    it { should validate_numericality_of(:unit_price).is_greater_than(0) }
    it { should validate_presence_of(:order) } # order_id presence
    it { should validate_presence_of(:book) } # book_id presence

    it 'is valid with valid attributes' do
      order_item = OrderItem.new(order: order, book: book, quantity: 2, unit_price: 15.00)
      expect(order_item).to be_valid
    end

    it 'is not valid without a quantity' do
      order_item = OrderItem.new(order: order, book: book, quantity: nil, unit_price: 10.0)
      expect(order_item).to_not be_valid
      expect(order_item.errors[:quantity]).to include("can't be blank")
    end

    it 'is not valid with quantity less than 1' do
      order_item = OrderItem.new(order: order, book: book, quantity: 0, unit_price: 10.0)
      expect(order_item).to_not be_valid
      expect(order_item.errors[:quantity]).to include("must be greater than or equal to 1")
    end

    it 'is not valid without a unit_price' do
      order_item = OrderItem.new(order: order, book: book, quantity: 1, unit_price: nil)
      expect(order_item).to_not be_valid
      expect(order_item.errors[:unit_price]).to include("can't be blank")
    end

    it 'is not valid with unit_price less than or equal to 0' do
      order_item = OrderItem.new(order: order, book: book, quantity: 1, unit_price: 0)
      expect(order_item).to_not be_valid
      expect(order_item.errors[:unit_price]).to include("must be greater than 0")
    end
  end
end