Faq.delete_all

10.times do
  Faq.create question: Faker::Lorem.sentence,
             answer: Faker::Lorem.paragraph
end


Quote.delete_all

10.times do
  Quote.create quote_line: Faker::Lorem.sentence,
                   author: Faker::Name.first_name
end


User.delete_all

user_array = []

10.times do
   user = User.create(first_name: Faker::Name.first_name,
            last_name: Faker::Name.last_name,
            email_address: Faker::Internet.email,
            password: "pass",
            password_confirmation: "pass")
   user_array.push(user.id)
end



Project.delete_all

10.times do
    project = Project.create(description: Faker::App.name)
    rand(6).times do
        Task.create(
                    project_id: project.id,
                    description: Faker::Lorem.sentence,
                    complete: [true, false, false, false].sample,
                    due_date: Faker::Time.forward(21)
        )
        Membership.create(
        user_id: user_array.sample,
        project_id: project.id,
        role: "Member"
            )
      end
end
