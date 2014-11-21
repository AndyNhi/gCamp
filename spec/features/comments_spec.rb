require 'rails_helper'

feature 'Comments' do

  before(:each) do
    @user = User.create!(
            first_name: Faker::Name.first_name,
            last_name: Faker::Name.last_name,
            email_address: Faker::Internet.email,
            password: "pass",
            password_confirmation: "pass")

    @project = Project.create!(description: Faker::App.name)

    @task = Task.create!(
            description: 'blah blah',
            due_date: '01/01/2999',
            project_id: @project.id
    )

  end

  def sign_in
    visit root_path
    click_on 'Sign In'
    fill_in 'Email address', with: @user.email_address
    fill_in 'Password', with: @user.password
    click_on 'Log In'
  end

  scenario 'can be added to task by user' do
    sign_in
    visit project_task_path(@project, @task)
    fill_in('comment_copy', :with=> 'BLAH')
    click_on 'Add Comment'
    expect(page).to have_content("BLAH")
  end

  scenario 'are timestamped' do
    sign_in
    visit project_task_path(@project, @task)
    fill_in('comment_copy', :with=> 'BLAH')
    click_on 'Add Comment'
    expect(page).to have_content('ago')
  end

end
