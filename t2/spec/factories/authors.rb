FactoryBot.define do
  factory :author do
    sequence(:name) { |n| "Author #{n}" }
    date_of_birth { '1970-01-01' }
    nationality { 'Korean' }
  end
end