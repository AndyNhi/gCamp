Faq.delete_all

10.times do
  Faq.create question: Faker::Lorem.sentence,
             answer: Faker::Lorem.paragraph
end

Task.delete_all

60.times do
  Task.create description: Faker::Lorem.sentence,
              complete: [true, false, false, false].sample,
              due_date: Faker::Time.forward(21)
end

Quote.delete_all

10.times do
  Quote.create quote_line: Faker::Lorem.sentence,
                   author: Faker::Name.first_name
end


User.delete_all

10.times do
  User.create first_name: Faker::Name.first_name,
               last_name: Faker::Name.last_name,
           email_address: Faker::Internet.email
end


Project.delete_all

10.times do
    Project.create description: Faker::App.name
end
