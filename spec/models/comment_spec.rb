# require 'rails_helper'
#
# describe 'Comment' do
#
#   before(:each) do
#     @user = User.create(first_name: Faker::Name.first_name,
#     last_name: Faker::Name.last_name,
#     email_address: Faker::Internet.email,
#     password: "pass",
#     password_confirmation: "pass")
#   end
#
#   it 'should exist' do
#     Comment.create!(copy: 'content of task')
#   end
#
#   it 'should have an associated user' do
#     comment = @user.comments.create!(copy: "content of task", user_id: @user.id)
#     comment.user_id.present?
#   end
#
# end
