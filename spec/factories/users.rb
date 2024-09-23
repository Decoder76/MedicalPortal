# spec/factories/users.rb
FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { "password123" }


    factory :doctor do
      role { :doctor }
    end

    factory :receptionist do
      role { :receptionist }
    end
  end
end
