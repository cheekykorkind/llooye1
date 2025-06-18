FactoryBot.define do
  factory :book do
    sequence(:title) { |n| "Book Title #{n}" }
    author
    published_year { 2020 }
    sequence(:isbn) { |n| "978-#{n.to_s.rjust(9, '0')}" }
    price { 25.00 }
    stock_quantity { 10 }
  end
end