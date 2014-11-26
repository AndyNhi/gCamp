# project and task defined in task.rb

FactoryGirl.define do
  factory :user do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    email_address { Faker::Internet.email }
    password "pass"
    password_confirmation "pass"
  end
end

FactoryGirl.define do
  factory :comment do
    association :task
    association :user
    copy { Faker::App.name }
  end
end
