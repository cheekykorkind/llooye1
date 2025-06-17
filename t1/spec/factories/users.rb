FactoryBot.define do
  factory :user do
    nickname { "MyString" }
    email { "MyText" }
    password_digest { "MyText" }
  end
end
