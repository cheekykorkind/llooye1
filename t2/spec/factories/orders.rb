FactoryBot.define do
  factory :order do
    sequence(:order_number) { |n| "ORD-#{n.to_s.rjust(3, '0')}" }
    order_date { Date.current }
    total_price { 0.00 }
    status { %w[pending shipped delivered cancelled].sample }
  end
end