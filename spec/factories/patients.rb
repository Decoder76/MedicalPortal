
FactoryBot.define do
  factory :patient do
    first_name { "John" }
    last_name { "Doe" }
    date_of_birth { Date.new(1980, 1, 1) }
    address { "123 Main St" }
    phone { "1234567890" }
  end
end
