FactoryGirl.define do
  factory :project do
    description { Faker::App.name }
  end
end

FactoryGirl.define do
  factory :task do
    association :project
    description { Faker::App.name }
    complete false
  end
end
