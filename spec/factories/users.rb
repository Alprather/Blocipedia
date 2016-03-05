FactoryGirl.define do
  pw = Faker::Name.title
  factory :user do
    username Faker::Name.title
    sequence(:email){|n| "user#{n}@factory.com" }
    password pw
    password_confirmation pw
    role :user
  end
end
