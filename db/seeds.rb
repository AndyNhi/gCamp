User.delete_all
Project.delete_all
Task.delete_all
Comment.delete_all
Membership.delete_all

admin = User.create!(
  first_name: 'Admin',
  last_name: 'User',
  admin: true,
  email_address: 'admin@example.com',
  password: 'password'
)

owner = User.create!(
  first_name: 'Owner',
  last_name: 'User',
  email_address: 'owner@example.com',
  password: 'password'
)

member = User.create!(
  first_name: 'Member',
  last_name: 'User',
  email_address: 'member@example.com',
  password: 'password'
)

user = User.create!(
  first_name: 'Basic',
  last_name: 'User',
  email_address: 'user@example.com',
  password: 'password'
)

multiple_owners = Project.create!(description: 'Multiple Owners')
Membership.create!(
  project: multiple_owners,
  user: owner,
  role: 'owner'
)
Membership.create!(
  project: multiple_owners,
  user: user,
  role: 'owner'
)
Membership.create!(
  project: multiple_owners,
  user: member,
  role: 'member'
)

task1 = Task.create!(
  description: "Write 3 comments",
  project: multiple_owners,
  due_date: 4.days.from_now
)

task2 = Task.create!(
  description: "Write 1 comment",
  project: multiple_owners,
  due_date: 5.days.from_now
)

3.times do
  Comment.create!(
  task: task1,
  user: owner,
  copy: Faker::Lorem.sentence
  )
end

Comment.create!(
  task: task2,
  user: member,
  copy: Faker::Lorem.sentence
)

single_owner = Project.create!(description: 'Single Owner')
Membership.create!(
  project: single_owner,
  user: owner,
  role: 'owner'
)
Membership.create!(
  project: single_owner,
  user: member,
  role: 'member'
)



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


user_array = []

30.times do
  user = User.create(first_name: Faker::Name.first_name,
  last_name: Faker::Name.last_name,
  email_address: Faker::Internet.email,
  password: "pass",
  password_confirmation: "pass")
  user_array.push(user.id)
end

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
    user_id: user_array.pop,
    project_id: project.id,
    role: "Member"
    )
  end
end
