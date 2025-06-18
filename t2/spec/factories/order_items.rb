FactoryBot.define do
  factory :order_item do
    order
    book
    quantity { 1 }
    unit_price { 10.00 }
  end
end