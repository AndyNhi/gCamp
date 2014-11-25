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
    due_date '01/01/1999'
  end
end
