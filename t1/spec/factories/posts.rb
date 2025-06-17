FactoryBot.define do
  factory :post do
    title { "MyString" }
    content { "MyText" }
    published_at { "2025-06-17 12:06:03" }
    status { 1 }
    user { nil }
  end
end
