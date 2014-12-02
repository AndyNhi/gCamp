require 'rails_helper'


feature "Task Crud" do

  before do
    @project = Project.create!(description: Faker::App.name)
    User.create!(first_name: 'Andy', last_name: 'Nguyen', email_address: 'example@email.com', password: 'pass', password_confirmation: 'pass')
    signin
  end

  def signin
    visit root_path
    click_on('Sign In')
    visit '/sign-in'
    fill_in 'Email', :with => 'example@email.com'
    fill_in 'Password', :with => 'pass'
    click_on 'Log In'
  end

  def create_task
    visit project_tasks_path(@project)
    click_on "Create Task"
    fill_in "Description", with: "test1"
    fill_in "Due date", with: "25/01/2999"
    click_on "Create Task"
    expect(page).to have_content "test1"
    click_on "Task"
  end

  scenario "user creates a task" do
    create_task
  end

  scenario "user shows a task" do
    create_task
    click_on "test1"
    expect(page).to have_content "test1"
  end

  scenario "user updates a task" do
    create_task
    click_on "Edit"
    fill_in "Description", with: "Andy"
    click_on "Update Task"
    expect(page).to have_content "Andy"
  end

  scenario "user can destroy a task" do
    create_task
    click_on "delete"
    expect(page).to have_no_content "test1"
  end

end


feature "Task Validation" do

  before do
    @project = Project.create(description: Faker::App.name)
    User.create!(first_name: 'Andy', last_name: 'Nguyen', email_address: 'example@email.com', password: 'pass', password_confirmation: 'pass')
    signin
  end

  def signin
    visit root_path
    click_on('Sign In')
    visit '/sign-in'
    fill_in 'Email', :with => 'example@email.com'
    fill_in 'Password', :with => 'pass'
    click_on 'Log In'
  end

  scenario "validates presence of description" do
    visit project_tasks_path(@project)
    click_on "Create Task"
    click_on "Create Task"
    expect(page).to have_content "Description can't be blank"
  end

  scenario "validates period restriction" do
    visit project_tasks_path(@project)
    click_on "Create Task"
    fill_in "Due date", with: "01/01/2011"
    click_on "Create Task"
    expect(page).to have_content "can't be in the past"
  end

end
