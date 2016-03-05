FactoryGirl.define do
  factory :wiki do
    title Faker::Name.title
    body Faker::Hipster.paragraph
    user
  end
end
