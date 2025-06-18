require 'rails_helper'

RSpec.describe Order, type: :model do
  describe 'Associations' do
    it { should have_many(:order_items) }
    it { should have_many(:books).through(:order_items) }
  end

  describe 'Validations' do
    it { should validate_presence_of(:order_number) }
    it { should validate_uniqueness_of(:order_number) }
    it { should validate_presence_of(:order_date) }
    it { should validate_presence_of(:total_price) }
    it { should validate_numericality_of(:total_price).is_greater_than_or_equal_to(0) }
    it { should validate_presence_of(:status) }
    it { should validate_inclusion_of(:status).in_array(%w[pending shipped delivered cancelled]) }

    it 'is valid with valid attributes' do
      order = Order.new(order_number: 'ORD-001', order_date: Date.current, total_price: 50.00, status: 'pending')
      expect(order).to be_valid
    end

    it 'is not valid without an order_number' do
      order = Order.new(order_number: nil, total_price: 10.0, status: 'pending')
      expect(order).to_not be_valid
      expect(order.errors[:order_number]).to include("can't be blank")
    end

    it 'is not valid with a duplicate order_number' do
      create(:order, order_number: 'ORD-002')
      order = build(:order, order_number: 'ORD-002')
      expect(order).to_not be_valid
      expect(order.errors[:order_number]).to include("has already been taken")
    end

    it 'is not valid with an invalid status' do
      order = build(:order, status: 'invalid_status')
      expect(order).to_not be_valid
      expect(order.errors[:status]).to include("is not included in the list")
    end

    it 'sets order_date to current date by default' do
      order = Order.create(order_number: 'ORD-DEF', total_price: 10.0, status: 'pending')
      expect(order.order_date).to eq(Date.current)
    end
  end

  describe 'Callbacks' do
    let(:author) { create(:author) }
    let(:book1) { create(:book, price: 10.00, stock_quantity: 5, author: author) }
    let(:book2) { create(:book, price: 20.00, stock_quantity: 3, author: author) }

    it 'calculates total_price before saving' do
      order = create(:order, order_number: 'ORD-CALC', total_price: 0, status: 'pending')
      create(:order_item, order: order, book: book1, quantity: 2, unit_price: book1.price) # 2 * 10 = 20
      create(:order_item, order: order, book: book2, quantity: 1, unit_price: book2.price) # 1 * 20 = 20
      order.reload
      expect(order.total_price).to eq(40.00)
    end
  end
end